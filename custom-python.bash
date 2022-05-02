mkfifo pyinput.pipe
mkfifo tee.pipe

tee input.log < tee.pipe > pyinput.pipe &
TEE_PID=$!
echo $TEE_PID

# exec 1>tmp.log
python3 -i < pyinput.pipe &
PYTHON_PID=$!
# exec 1>/dev/tty
# rm tmp.log
echo $PYTHON_PID

sleep infinity > tee.pipe &
PIPE_PID=$!
echo $PIPE_PID

COMMAND=""
while [[ $COMMAND != "quit()" ]]
do
    read COMMAND
    echo $COMMAND>tee.pipe
done

kill -9 $TEE_PID
kill -9 $PYTHON_PID
kill -9 $PIPE_PID
rm *.pipe
