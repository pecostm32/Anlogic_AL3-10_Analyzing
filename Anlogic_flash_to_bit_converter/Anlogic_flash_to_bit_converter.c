/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   main.c
 * Author: peter
 *
 * Created on April 9, 2019, 1:04 PM
 */


#include <stdio.h>      // standard input / output functions
#include <stdlib.h>
#include <string.h>


#if 0
# Anlogic Infotech Corporation ASCII Bitstream
# Version: 5.0.28716
# Design name: Scope
# Architecture: al3_10
# Package: LQFP144
# Date: 2022/ 1/23 18: 0
# Bitstream CRC: 0110101110011101
# USER CODE: 00000000000000000000000000000000


The above is the header that needs to be written to the beginning of the bit file. The problem is the CRC, which probably needs to be determind first.

The flash file starts with the 0xFF data. 32 bytes when correct, and these need to be split into two blocks with a big endian 16 bit size before them
size, data fields

Then the file should have a pre amble of 0xCC55AA33

After this a tagged set of data is presented.

See: https://github.com/mmicko/prjtang/blob/master/docs/architecture/bitstream_format.rst for more info

The CRC seems to be CRC-16/BUYPASS
  
  
The structure of the command data:

1) Tag    1 byte
2) Flag   1 byte
3) Size   2 bytes
4) Data   either 2, 4 or more?? bytes
5) CRC    2 bytes


The CRC is calculated over
1) Tag
2) Flag
3) Size

4) The bytes of a frame defined by the chip type. In the data stream there are extra bytes and they contain a CRC. Only 257 bytes are frame data. Then the CRC follows and then 4 zero padding bytes.

The prjtang code checks this CRC per frame and resets the CRC afteer each frame

The question remains which data is checked with the header CRC.
#endif






typedef unsigned char  uchar;
typedef unsigned int   uint;
typedef unsigned short uint16;


const uchar header[] = "# Anlogic Infotech Corporation ASCII Bitstream\n# Version: 5.0.28716\n# Design name: Scope\n# Architecture: al3_10\n# Package: LQFP144\n# Date: 2022/ 1/23 18: 0\n# Bitstream CRC: 0110101110011101\n# USER CODE: 00000000000000000000000000000000\n\n";

//The CRC in the header needs to be correct. So need to calculate the CRC based on the actual bit data
//And when calculated it needs to be converted to a 0 1 string of 16 digits and needs to be placed over the data already in the header (Offset 173)

#define CRC16_POLY  0x8005

uint16 update_crc16(uint16 crc16, uchar val)
{
  int bit_flag;
  int i;

  for(i=7;i>=0;i--)
  {
    bit_flag = crc16 >> 15;

    /* Get next bit: */
    crc16 <<= 1;

    crc16 |= (val >> i) & 1; // item a) work from the least significant bits

    /* Cycle check: */
    if(bit_flag)
    {
      crc16 ^= CRC16_POLY;
    }
  }
  
  return(crc16);
}

uint16 finalise_crc16(uint16 crc16)
{
  // item b) "push out" the last 16 bits
  int i;
  int bit_flag;
  
  for(i=0;i<16;++i)
  {
    bit_flag = crc16 >> 15;
    
    crc16 <<= 1;
    
    if(bit_flag)
    {
      crc16 ^= CRC16_POLY;
    }
  }

  return(crc16);
}




int main(int argc, char** argv)
{
  uchar flash_data[2097152];
  uchar bit_data[2097152];
  
  uchar *sptr;
  uchar *dptr;
  uchar *cptr;
  uchar *eptr;
  
  uchar tag;
  uchar flag;
  int   size;
  int   blocks;
  
  int state = 0;
  int i;
  
  uint16 crc = 0;
  
  int length;
  
  FILE *fp = fopen("W25Q80_FPGA.bin", "rb");
//  FILE *fp = fopen("Scope5.bin", "rb");
  
  
  memcpy(bit_data, header, sizeof(header) - 1);
  
  dptr = &bit_data[sizeof(header) - 1];
  
  if(fp)
  {
    //Get the bitstream data
    length = fread(&flash_data, 1, sizeof(flash_data), fp);

    fclose(fp);

    sptr = flash_data;
    eptr = &flash_data[length];

    cptr = sptr;
    
    while(sptr < eptr)
    {
      switch(state)
      {
        case 0:
          //Set the size of the 0xFF field
          *dptr++ = 0x00;
          *dptr++ = 0x80;
          
          //Need a check if the data is actually a 0xFF string
          
          //Copy the 16 bytes
          memcpy(dptr, sptr, 16);
          
          //Skip to next field in the buffers
          dptr += 16;
          sptr += 16;
          
          //On to next state
          state = 1;
          break;

        case 1:
          //Set the size of the 0xFF field
          *dptr++ = 0x00;
          *dptr++ = 0x80;
          
          //Copy the 16 bytes
          memcpy(dptr, sptr, 16);

          //Need a check if the data is actually a 0xFF string
          
          //Skip to next field in the buffers
          dptr += 16;
          sptr += 16;
          
          //On to next state
          state = 2;
          break;
          
        case 2:
          //Set the size of the preamble field
          *dptr++ = 0x00;
          *dptr++ = 0x20;
          
          //Copy the 4 bytes
          memcpy(dptr, sptr, 4);
          
          //Need a check on the preamble being 0xCC55AA33
          
          //Skip to next field in the buffers
          dptr += 4;
          sptr += 4;
          
          //On to next state
          state = 3;
          break;
          
        case 3:
          //In this state the actual fields need to be processed based on tag, flag, size and data
          tag = sptr[0];
          flag = sptr[1];
          size = (sptr[2] << 8) | sptr[3];
          
          
          //When the EC tag is found it is written as a four byte filed, so bit size is 0x0020
          //Then a new size, data structure follows
          //This is a bit unclear as to how this works.
          
          //The EC tag says 1075 blocks, and in a bit file is gives a size of 0x0838, which is 263 bytes. The question is if this can be translated back from the flash data
          //The actual frame data is 257 bytes, followed by two CRC bytes and four zero padding bytes
          if(tag == 0xEC)
          {
            //Need the number of blocks
            blocks = size;
            
            //Only 4 bytes for the 0xEC tag
            size = 4;
            
            //Skip to the next state for block handling
            state = 4;
          }
          else
          {
            size += 4;
          }
          
          //Calculate the length of the segment in bits
          length = size * 8;
          
          //Set the size of the field
          *dptr++ = (length >> 8) & 0xFF;
          *dptr++ = length & 0xFF;
          
          //Copy the bytes
          memcpy(dptr, sptr, size);
          
          //Skip to next field in the buffers
          dptr += size;
          sptr += size;
          
          //Check on last tag
          if(tag == 0xF7)
          {
            state = 5;
          }
          break;

        case 4:
          //Need to handle blocks here
          //Set the size of the block field
          *dptr++ = 0x08;
          *dptr++ = 0x38;
          
          //Copy the bytes
          memcpy(dptr, sptr, 263);
          
          //The data copied here is the actual FPGA programming data, which needs to be determined what the meaning of each bit is.

          //Skip to next field in the buffers
          dptr += 263;
          sptr += 263;
          
          //Take one block off
          blocks--;
          
          if(blocks == 0)
          {
            //Need to handle a padding block here. 0x78 bits long (15 bytes)
            //Set the size of the block field
            *dptr++ = 0x00;
            *dptr++ = 0x78;
            
            //Copy the  bytes
            memcpy(dptr, sptr, 15);

            //Skip to next field in the buffers
            dptr += 15;
            sptr += 15;
            
            //Check if last block done, and switch bag to tag handling if so
            state = 3;
          }
          
          break;
          
        case 5:
          //Set the size of the 0xFF field
          *dptr++ = 0x00;
          *dptr++ = 0x80;
          
          //Need a check if the data is actually a 0xFF string
          
          //Copy the 16 bytes
          memcpy(dptr, sptr, 16);
          
          //Skip to next field in the buffers
          dptr += 16;
          sptr += 16;
          
          //On to next state
          state = 6;
          break;

        case 6:
          //Set the size of the 0xFF field
          *dptr++ = 0x00;
          *dptr++ = 0x80;
          
          //Need a check if the data is actually a 0xFF string
          
          //Copy the 16 bytes
          memcpy(dptr, sptr, 16);
          
          //Skip to next field in the buffers
          dptr += 16;
          sptr += 16;
          
          //Done with data so make the loop quit
          eptr = sptr;
          break;
      }
    }
    
    
    
    
    //Calculate the bitstream CRC for the header. This is done over the raw bitstream data without the blocking
    while(cptr < eptr)
    {
      crc = update_crc16(crc, *cptr++);
    }
    
    crc = finalise_crc16(crc);
    
    sptr = &bit_data[173];
    
    //Copy the CRC to the buffer
    for(i=0;i<16;i++)
    {
      if(crc & 0x8000)
      {
        *sptr++ = 0x31;
      }
      else
      {
        *sptr++ = 0x30;
      }
      
      crc <<= 1;
    }
    

    if(fp = fopen("Original_1013D_fpga.bit", "wb"))
//    if(fp = fopen("Scope5.bit", "wb"))
    {
    
      fwrite(bit_data, 1, dptr - bit_data, fp);
    
      fclose(fp);
    }
  }
  
  
}
