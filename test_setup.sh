# This script needs to be run from benchmark-fastapi_gin_express directory


echo "Setting up BlackSheep"
python3 -m venv blacksheep_app/.venv
echo "Install BlackSheep and Uvicorn"
blacksheep_app/.venv/bin/pip install -r blacksheep_app/requirements.txt
echo "BlackSheep setup success"

echo ""

echo "Setting up Gin"
cd gin_app
go mod init gin_app
go get -u github.com/gin-gonic/gin
cd ..
echo "Gin setup success"

echo ""

echo "Setting up Fiber"
cd fiber_app
go mod init fiber_app
go get -u github.com/gofiber/fiber/v3
cd ..
echo "Fiber setup success"

echo ""

echo "Setting up echo"
cd echo_app
go mod init echo_app
go get -u github.com/labstack/echo/v4
echo "Echo setup success"

echo ""

echo "Setting up net/http"
cd go.net.http_app
go mod init net_http_app
go get -u github.com/julienschmidt/httprouter
cd ..
echo "net/http setup success"

echo ""

echo "Setting up Express"
cd express_app
npm init
npm install express
cd ..
echo "Express setup success"

echo ""

echo "Setting up Drill"
cargo install drill
echo "Drill setup success"
