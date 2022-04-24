integer rez_height      =
/*Change the number below to change the rez height*/
/* ---> */ 5 /* <--- */
/* DO NOT CHANGE ANYTHING BELOW */
;
vector  new;
calculate_vector()
{
    float p=(float)rez_height;
    p=p/10;
    new=<0.0,0.0,p>;
}
count()
{
    integer i=llGetInventoryNumber(INVENTORY_OBJECT);
    string  msg;
    if (i>0) {
        msg=">"+(string)i+" meal(s) left<";

        key date = llGetTimestamp();
        key id = llDetectedKey(0);

        list parcelDetails = llGetParcelDetails(llGetPos(), [PARCEL_DETAILS_NAME]);

        llInstantMessage( llGetCreator(), msg );
        llInstantMessage( llGetCreator(), (string)date );
        llInstantMessage( llGetCreator(), llList2String(parcelDetails ,0) );
        llSetLinkColor(LINK_THIS, <0.2,0.8,0.2>, ALL_SIDES);
    } else {
        msg="EMPTY meal box";

        key userName = llGetUsername(llDetectedKey(0));
        key date = llGetTimestamp();
        key  id      = llDetectedKey(0);

        list parcelDetails = llGetParcelDetails(llGetPos(), [PARCEL_DETAILS_NAME]);

        llInstantMessage( llGetCreator(), msg );
        llInstantMessage( llGetCreator(), (string)userName );
        llInstantMessage( llGetCreator(), (string)date );
        llInstantMessage( llGetCreator(), llList2String(parcelDetails ,0) );

    }
    llSetText(msg,<1,1,1>,1);
}
rez()
{
    integer i=llGetInventoryNumber(INVENTORY_OBJECT);
    if (i>0) {
        llRezObject(llGetInventoryName(INVENTORY_OBJECT,0),llGetPos()+new,<0.0,0.0,0.0>,<0.0,0.0,0.0,1.0>,0);
    }
    count();
}

float gap = 30.0;
float counter = 0.0;

default
{
     on_rez(integer a)
    {
        count();
        calculate_vector();
        llResetScript();
    }

    state_entry()
    {
        // Activate the timer listener every 2 seconds
        //llSetTimerEvent(gap);
        count();
        calculate_vector();
    }

     touch_start(integer total_number)
    {
        integer x;
        for (; x<total_number; x++) {
            key usr=llDetectedKey(x);
            if (llSameGroup(usr) || usr==llGetOwner()) {
                rez();
            }
        }
    }
    changed(integer c)
    {
        if (c&CHANGED_INVENTORY) {
            count();
        }
    }

  //  timer()
  //  {

    //            rez();

      //  }

        //counter = counter + gap;
        //llSay(0, (string)counter+" seconds have passed");


}
