#!/bin/bash
    
    #i make a dialog box asking if the user wants to install dependencies
dialog --title "Dependencies" --yesno "Before we begin, we need to install the following dependencies: JRE, Curl , Dialog. Do you want to continue?" 0 0
if [ $? -eq 0 ]; then
     #install the neccesary dependencies
sudo apt install jre -y
sudo apt install dialog -y
sudo apt install curl -y
else
    echo "goodbye"
exit

fi
    #Go to root directory
cd..
cd.. 
cd..
cd..
    #specify root directory
Dir=$(pwd)
    #dialogbox that starts the creation of the isntallation directory
dialog --Title "Installation path" --msgbox "This will install the node in the following directory $dir/ergo_node" 0 0
mkdir -p "$dir/ergo_node

cd "$dir/ergo_node

  #creates a dialog box to chose the node type
var=$(dialog --title "Node selection" --menu "Select a node" 0 0 0 \
    1 "Light" \
    2 "Full" \
    3 "None" \
    3>&1 1>&2 2>&3 3>&-)


case $var in
    1)
        # Light option was selected, modify ergo.conf
        dialog -title "Succes" --msgbox "light node"
         cat <<EOF >ergo.conf
ergo {
  node {
    stateType = "digest"
    blocksToKeep = 1440
    mining = false
    nipopow {
      nipopowBootstrap = true
      p2pNipopows = 2
    }
  }
}

scorex {
  restApi {
    apiKeyHash = "6ed54addddaf10fe8fcda330bd443a57914fbce38a9fa27248b07e361cc76a41"
  }
}
EOF
                ;;
    2)
        # Full option was selected
        echo "You selected Full."
        # Add logic here if necessary
        ;;
    3)
        # None option was selected
        echo "You selected None."
        # Add logic here if necessary
        ;;
    *)
        # Default option, should not occur in this case
        echo "Invalid selection."
        ;;
esac

dialog --title "Installation finished" --yesno "Do you wish to start your node now?" 0 0

if [ $? -eq 0 ]; then

    java -jar $jar_file --mainnet -c ergo.conf 

    else 

    exit

    fi