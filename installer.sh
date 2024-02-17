#!/bin/bash

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
