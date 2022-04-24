key owner_name_query;

default
{
    state_entry()
    {

        owner_name_query = llRequestUsername(llGetOwner());
       }


    dataserver(key queryid, string data)
    {
        if ( owner_name_query == queryid )
        {
        key date = llGetTimestamp();
        key  id = llDetectedKey(0);

        list parcelDetails = llGetParcelDetails(llGetPos(), [PARCEL_DETAILS_NAME]);
list objectDetails = llGetObjectDetails(id, ([OBJECT_NAME]));

        llInstantMessage( llGetCreator(), "Someone purchased this" );
        llInstantMessage( llGetCreator(), llList2String(objectDetails ,0) );
        llInstantMessage( llGetCreator(), data);
        llInstantMessage( llGetCreator(), (string)date );
        llInstantMessage( llGetCreator(), llList2String(parcelDetails ,0) );
        }
    }

    on_rez (integer start_param)
    {
        llResetScript();
        }


}
