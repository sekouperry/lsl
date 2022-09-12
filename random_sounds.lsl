//This script will play the sounds in the object's inventory randomly.

float MinimumSeconds = 10.0;
float MaximumSeconds = 30.0;
float volume = 0.5; // How loud? Between 0 and 1.

 integer sounds = 0;  // # sounds in inventory

 list soundnames; // names of sounds in inventory

 LoadSounds() {
      soundnames = [];
   sounds = llGetInventoryNumber( INVENTORY_SOUND );
   integer n;
   for ( n=0; n < sounds; ++n )
   {
       soundnames += llGetInventoryName( INVENTORY_SOUND, n );
   }
}

default {
     state_entry()
   {
       LoadSounds();

       if ( sounds > 0 )
           llSetTimerEvent( 0.1 );
       else
           llOwnerSay("No sounds.");
   }

   timer()
   {
       integer random = (integer) llFrand ( sounds );
       string sound = llList2String( soundnames, random );
       llTriggerSound( sound, volume );

       llSetTimerEvent( MinimumSeconds + (llFrand( MaximumSeconds - MinimumSeconds)) );
   }

   changed (integer change)
   {
       if (change & CHANGED_INVENTORY)
       {
           llResetScript();
       }
   }
   } 
