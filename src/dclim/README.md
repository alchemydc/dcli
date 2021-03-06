# dclim

Command line tool for managing and syncing the remote Destiny 2 API manifest database.

The utility will check whether a more current version of the Destiny 2 API manifest database is avaliable (comparing it to the last version which has been downloaded). If a new version is found, it will download the database, uncompress it, and save it to the directory specified when calling the utility. It will also save a file containting metadata about the current version, which is used for future checks for updates.

The utility expects that the downloaded manifest will not be moved from the directory it is downloaded to, and uses that information to determine whether a new version is avaliable. If the manifest is moved, the utility will re-download the manifest on next check.

The utility uses the download url for the manifest to check for a new version. While it displays the version number, that is not used to detect whether a new version is avaliable.

The manifest is a [Sqlite 3](https://www.sqlite.org/index.html) database.

## USAGE
```
USAGE:
    dclim [FLAGS] [OPTIONS] --manifest-dir <manifest-dir>

FLAGS:
    -c, --check      
            Check whether a new manifest version is available, but do not download

    -f, --force      
            Force a download of manifest regardless of whether it has been updated

    -h, --help       
            Prints help information

    -V, --version    
            Prints version information

    -v, --verbose    
            Print out additional information
            
            Output is printed to stderr.

OPTIONS:
    -m, --manifest-dir <manifest-dir>    
            Directory where the manifest and meta-data will be stored

    -o, --output <output>                
            Format for command output
            
            Valid values are default (Default) and tsv.
            
            tsv outputs in a tab (\t) seperated format of name / value pairs with lines ending in a new line character
            (\n). [default: default]
```

### Examples

#### Check for an updated manifest and store any new version in *~/manifest/*:
```
dclim --manifest-dir ~/manifest/
```

#### Download remote manifest and store in *~/manifest/* directory regardless of whether remote is updated.
```
dclim --manifest-dir ~/manifest/ --force
```

#### Check status of remote manifest, but do not download. Print out additional information.
```
dclim --manifest-dir ~/manifest/ --check --verbose
```

which outputs:

```
https://www.bungie.net/Platform/Destiny2/Manifest/
Remote Manifest version       89360.20.11.18.2249-6
Remote Manifest url           https://www.bungie.net/common/destiny2_content/sqlite/en/world_sql_content_df27bd2a2e07a18c6f4b53c68449afd4.content
Local Manifest version        89031.20.11.10.1952-1
Local Manifest url            https://www.bungie.net/common/destiny2_content/sqlite/en/world_sql_content_43b136a4cf20d3fe266da21319600a31.content
Updated manifest available    89360.20.11.18.2249-6
```

#### Check for an updated manifest print output in a tab seperated format (tsv)

```
dclim --manifest-dir ~/manifest/ --output tsv
```

outputs:

```
local_path      /Users/mesh/manifest/manifest.sqlite3
updated true
version 89360.20.11.18.2249-6
```

This shows that the local path for the manifest, and indicates that it was just updated.


## Compiling

This utility is written and compiled in [Rust](https://www.rust-lang.org/).

When compiling you must have an environment variable named `DESTINY_API_KEY` which contains your [Bungie API key](https://www.bungie.net/en/Application).

To compile, switch to the base directory for the program, and run:

```
cargo build --release
```

which will place the build in *target/release*