module.exports = (srv) => { 
    srv.on('hello', (req) => {
        let myName = req.data.name;
        return "Hello Amigo " + myName;
    });
 
    const { employees } = cds.entities("jagga.db.master");
 
    srv.on('READ', 'EmployeeSrv', async (req) => {
       
        const tx = cds.tx(req);
        var data = await tx.run(SELECT.from(employees).where({
            "Currency_code": "USD"
        }).limit(3));
 
        data.push({
            "ID":"Zkas",
            "nameFirst": "Anil",
            "nameLast": "Kapoor"
        });
       
        return data;
 
    });
 
}
