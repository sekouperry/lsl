string Banana =
"DFS Smoothie Banana

DFS Freezer
Slot - Item
1 - DFS Banana Basket
2 - DFS Yogurt - Plain
3 - DFS Ice Tray
4 - DFS Honey Jar
5 - DFS Milk Crate

Time : 00:02:00
1 Use - 52 EP/use - 1 XP
----------------------------";

string Berry =
"DFS Smoothie Berry

DFS Freezer
Slot - Item
1 - DFS Berry Basket
2 - DFS Yogurt - Plain
3 - DFS Ice Tray
4 - DFS Honey Jar
5 - DFS Milk Crate

Time : 00:02:00
1 Use - 52 EP/use - 1 XP
----------------------------";

string Orange =
"DFS Smoothie Orange

DFS Freezer
Slot - Item
1 - DFS Orange Basket
2 - DFS Yogurt - Plain
3 - DFS Ice Tray
4 - DFS Honey Jar
5 - DFS Milk Crate

Time : 00:02:00
1 Use - 52 EP/use - 1 XP
----------------------------";

string Strawberry =
"DFS Smoothie Strawberry

DFS Freezer
Slot - Item
1 - DFS Strawberry Basket
2 - DFS Yogurt - Plain
3 - DFS Ice Tray
4 - DFS Honey Jar
5 - DFS Milk Crate

Time : 00:02:00
1 Use - 52 EP/use - 1 XP
----------------------------";

// When the prim is touched, give the toucher the option of killing the prim.

integer gListener;     // Identity of the listener associated with the dialog, so we can clean up when not needed

default
{
    touch_start(integer total_number)
    {
        // Kill off any outstanding listener, to avoid any chance of multiple listeners being active
        llListenRemove(gListener);
        // get the UUID of the person touching this prim
        key user = llDetectedKey(0);
        // Listen to any reply from that user only, and only on the same channel to be used by llDialog
        // It's best to set up the listener before issuing the dialog
        gListener = llListen(-99, "", user, "");
        // Send a dialog to that person. We'll use a fixed negative channel number for simplicity
        llDialog(user, "\nWhat do you want to cook?", ["Banana", "Berry", "Orange", "Strawberry" ] , -99);
        // Start a one-minute timer, after which we will stop listening for responses
        llSetTimerEvent(60.0);
    }
    listen(integer chan, string name, key id, string msg)
    {
        // If the user clicked the "Yes" button, kill this prim.
        if (msg == "Banana")
            llSay(0, Banana);
        if (msg == "Berry")
            llSay(0, Berry);
        if (msg == "Orange")
            llSay(0, Orange);
        if (msg == "Strawberry")
            llSay(0, Strawberry);
        // The user did not click "Yes" ...
        // Make the timer fire immediately, to do clean-up actions
        llSetTimerEvent(0.1);
    }
    timer()
    {
        // Stop listening. It's wise to do this to reduce lag
        llListenRemove(gListener);
        // Stop the timer now that its job is done
        llSetTimerEvent(0.0);// you can use 0 as well to save memory
    }
}
