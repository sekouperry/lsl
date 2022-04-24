key owner;
key sound="sound-uuid";//to add your own sound, right click the wanted sound, 'copy asset uuid' and put it between teh baracktets same as above "<key here>", or put the wanted sound in the object inventory and copy its exect name in between the barackets instead.
default
{
    changed(integer ch)
    {
        if(ch&CHANGED_OWNER)
        {
            llResetScript();
        }
    }
    state_entry()
    {
        owner=llGetOwner();
      llSetTimerEvent(0.1);
    }
    timer()
    {
        if(llGetAgentInfo(owner)&AGENT_WALKING)
        {
            llLoopSound(sound,1.0);
        }
        else
        llStopSound();
        {
        }
    }
}
