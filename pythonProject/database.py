"""
Database and Database Path Management
"""
import os
from os import path
import json
import subprocess
import sys


def get_tang_root():
    """Return the absolute path to the Project Tang repo root"""
    return path.abspath(path.join(__file__, "../../../"))


def get_tangdinasty_root():
    """
    if "TD_HOME" not in os.environ:        
        print("TD_HOME must be set")
        sys.exit(-1)
    if not path.exists(path.join(os.environ["TD_HOME"], "bin", "td")) and not path.exists(path.join(os.environ["TD_HOME"], "bin", "td.exe")):
        print("TD_HOME must point to directory containing TangDinasty software")
        sys.exit(-1)
    return path.abspath(os.environ["TD_HOME"])
    """
    # return path.abspath("/home/peter/Downloads/Anlogic/TD_5.0.3_28716_NL")
    return path.abspath("/home/peter/Downloads/Anlogic/TD_RELEASE_DECEMBER2018_GOLDEN_RHEL")


def get_db_root():
    """
    Return the path containing the Project Tang database
    This is database/ in the repo, unless the `PRJTANG_DB` environment
    variable is set to another value.
    if "PRJTANG_DB" in os.environ and os.environ["PRJTANG_DB"] != "":
        return os.environ["PRJTANG_DB"]
    else:
        return path.join(get_tang_root(), "database")
    """
    return path.abspath("/home/peter/database")


def get_db_subdir(family = None, device = None, package = None):
    """
    Return the DB subdirectory corresponding to a family, device and
    package (all if applicable), creating it if it doesn't already
    exist.
    """
    subdir = get_db_root()
    if not path.exists(subdir):
        os.mkdir(subdir)
    dparts = [family, device, package]
    for dpart in dparts:
        if dpart is None:
            break
        subdir = path.join(subdir, dpart)
        if not path.exists(subdir):
            os.mkdir(subdir)
    return subdir


def get_tilegrid(family, device):
    """
    Return the deserialised tilegrid for a family, device
    """
    tgjson = path.join(get_db_subdir(family, device), "tilegrid.json")
    with open(tgjson, "r") as f:
        return json.load(f)


def get_devices():
    """
    Return the deserialised content of devices.json
    """
    djson = path.join(get_tang_root(), "devices.json")
    with open(djson, "r") as f:
        return json.load(f)

def get_db_commit():
    return subprocess.getoutput('git -C "{}" rev-parse HEAD'.format(get_db_root()))
