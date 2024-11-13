using { jagga.db.master  } from '../db/datamodel';

//Service definition
service MyService @(path: 'MyService') {

    function hello(name: String) returns String;
    entity EmployeeSrv as projection on master.employees;
 
}