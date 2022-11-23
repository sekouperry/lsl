//Script for texture change receptor
integer channel=1376105;
//Channel is the integer for reception (Number must be the same as a transmission channel otherwise script will not work )

default
{
    state_entry()
    {
        llListen(channel,"",NULL_KEY,"");
    }

    listen(integer channel, string name, key id, string msg)
    {
       if (llGetOwner() == llGetOwnerKey(id))
       //Checks if the owner of the object who is sending a message its the same owner of the receptor .
       {
           llSetTexture(llGetSubString(msg,0,-1),ALL_SIDES);
        }
    }
}
