<?php 
class Conexion{	  
    public static function Conectar() {        
        define('servidor', getenv('DB_HOST',true));
	define('nombre_bd', getenv('DB_NAME',true));
        define('usuario', getenv('DB_USER',true));
        define('password', getenv('DB_USER_PASSWORD',true));
        $opciones = array(PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8');			
        try{
            $conexion = new PDO("mysql:host=".servidor."; dbname=".nombre_bd, usuario, password, $opciones);			
            return $conexion;
        }catch (Exception $e){
            die("El error de Conexión es: ". $e->getMessage());
        }
    }
}
