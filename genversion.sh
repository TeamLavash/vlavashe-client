VERSION=$(git describe --tags --long)

VERSION_FILE=app/src/main/java/com/example/kormick/vlavashe_client/Version.java

echo "package com.example.kormick.vlavashe_client;"       >  $VERSION_FILE
echo "// Version: "$VERSION_FILE""                        >> $VERSION_FILE
echo "public class Version {"                             >> $VERSION_FILE
echo "\tpublic static final String version = "$VERSION";" >> $VERSION_FILE
echo "}"                                                  >> $VERSION_FILE