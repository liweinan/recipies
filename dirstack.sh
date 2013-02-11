mypushd()
{
   dirname=$1
   if [ -n $dirname ] && [ \( -d $dirname \) -a \( -x $dirname \) ]; then
      DIR_STACK=${dirname}' '${DIR_STACK:-$PWD}' '
      cd $dirname
      echo "$DIR_STACK"
   else
      echo "still in $PWD."
   fi
} 

mypopd()
{
   if [ -n "$DIR_STACK" ]; then            
      DIR_STACK=${DIR_STACK#* }
      cd ${DIR_STACK%% *}      
      echo "$DIR_STACK"
   else
      echo "stack empty, still in $PWD."
   fi
}
