echo "-------- Starting Fiber Server --------"
cd fiber_app
go run app.go &
sleep 3
go_fiber_pid=$(ps aux | grep '/tmp/go-build' | grep -v grep | awk {'print $2'} | xargs)
echo "-------- Benchmarking Fiber --------"
drill --benchmark fiber.yaml -q -n --stats
echo "-------- Stoping Fiber Server --------"
kill -9 $go_fiber_pid
cd ..
    
echo "-------- Starting BlackSheep Server --------"
blacksheep_app/.venv/bin/python blacksheep_app/app.py &
sleep 3
blacksheep_pid=$(ps aux | grep 'blacksheep_app/.venv/bin/python blacksheep_app/app.py' | grep -v grep | awk {'print $2'} | xargs)
echo "-------- Benchmarking BlackSheep --------"
drill --benchmark blacksheep_app/blacksheep.yaml -q -n --stats
echo "-------- Stoping BlackSheep Server --------"
kill $blacksheep_pid

sleep 3
echo " " 

echo "-------- Starting BlackSheep Server with Workers --------"
blacksheep_app/.venv/bin/uvicorn app:app --port 44777 --workers 6 --no-access-log --app-dir blacksheep_app &
sleep 3
blacksheepw_pid=$(ps aux | grep 'blacksheep_app/.venv/bin/uvicorn app:app --port 44777 --workers 6 --no-access-log --app-dir blacksheep_app' | grep -v grep | awk {'print $2'} | xargs)
echo "-------- Benchmarking BlackSheep with Workers --------"
drill --benchmark blacksheep_app/blacksheep.yaml -q -n --stats
echo "-------- Stoping Fastapi Server --------"
kill $blacksheepw_pid

sleep 3
echo " " 

echo "-------- Starting BlackSheep Server with Gunicorn --------"
blacksheep_app/.venv/bin/gunicorn -b :8001 -w 6 -k uvicorn.workers.UvicornWorker --chdir blacksheep_app app:app &
sleep 3
blacksheepg_pid=$(ps aux | grep 'blacksheep_app/.venv/bin/gunicorn -b :8001 -w 6 -k uvicorn.workers.UvicornWorker --chdir blacksheep_app app:app' | grep -v grep | awk {'print $2'} | xargs)
echo "-------- Benchmarking Blacksheep with Gunicorn --------"
drill --benchmark blacksheep_app/blacksheep.yaml -q -n --stats
echo "-------- Stoping BlackSheep Server --------"
kill $blacksheepg_pid

sleep 3
echo " " 

echo "-------- Starting Gin Server --------"
cd gin_app
go run app.go &
sleep 3
go_pid=$(ps aux | grep '/tmp/go-build' | grep -v grep | awk {'print $2'} | xargs)
echo "-------- Benchmarking Gin --------"
drill --benchmark gin.yaml -q -n --stats
echo "-------- Stoping Gin Server --------"
kill -9 $go_pid
cd ..



sleep 3
echo " "

echo "-------- Starting Express Server --------"
node express_app/app.js &
sleep 3
express_pid=$(ps aux | grep 'node express_app/app.js' | grep -v grep | awk {'print $2'} | xargs)
echo "-------- Benchmarking Express --------"
drill --benchmark express_app/express.yaml -q -n --stats
echo "-------- Stoping Express Server --------"
kill -9 $express_pid

