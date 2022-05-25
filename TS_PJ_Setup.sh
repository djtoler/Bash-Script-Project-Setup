echo "Project name?"
read Project
echo "Project created: $Project"
echo "React or HBS? (Type r or h)"
read Client
echo "Client is $Client"
mkdir "$Project"
cd "$Project"
mkdir src
mkdir tests
touch src/index.ts
mkdir src/models
mkdir src/routes
#conditional
if [ "$Client" != "r" ]
then
mkdir src/views
mkdir src/public
fi
#end conditional
touch .gitignore
echo "node_modules/" >> .gitignore
npm init -y
sed '/"test":/d' package.json >temp.json
sed '/"scripts": {/ a  "start": "ts-node src/index.ts",\n  "start:dev": "nodemon src/index.ts",\n  "test": "jest",\n  "test:dev": "jest --watchAll --verbose"' temp.json >temp2.json
cat temp2.json >package.json
rm temp2.json temp.json
#conditional
if [ "$Client" != "r" ]
then
npm i -D typescript ts-node nodemon jest @types/jest ts-jest @types/express @types/cors @types/hbs
npm i express cors hbs
else
npm i -D typescript ts-node nodemon jest @types/jest ts-jest @types/express @types/cors
npm i express cors
fi
#end conditional
npx tsc --init
npx ts-jest config:init
#conditional
if [ "$Client" = "r" ]
then
npx create-react-app client --template typescript
echo "created client folder"
fi