module.exports = cds.service.impl(async function () {

    ///get access of database table/entity

    const { EmployeeSet, POs } = this.entities;

    this.before('UPDATE', EmployeeSet, (req) => {
        //here we write our code which we want to plug-in
        //just before the data is updated in employee table

        if (req.data.salaryAmount >= 1000000) {
            req.error(500, "OMG, this is too much salary");
        }
    });

    this.before('CREATE', EmployeeSet, (req1) => {
        //here we write our code which we want to plug-in
        //just before the data is updated in employee table
     
        if (req1.data.salaryAmount >= 1000000) {
            req1.error(500, "OMG, this is too much salary");
        }
        
    });

    // this.on('READ', async (req, res) => {
    //     //CQL - CDS query language to communicate to DB
    //     try {
    //         const ID = req.params[0];
    //         console.log("Read Update");
    //         const tx = cds.tx(req);
    //         await tx.update(POs).with({
    //             GROSS_AMOUNT: {'.replaceAll(",","")' : [{ref:['GROSS_AMOUNT']}]}
    //         });

    //         var mydata = tx.read(POs);
    //         return mydata;

    //     } catch (error) {
    //         return "Error " + error.toString();
    //     }
    // });

    this.on('boost', async (req, res) => {
        //CQL - CDS query language to communicate to DB
        try {
            const ID = req.params[0];
            //console.log("Hey Amigo, Your purchase order with id " + JSON.stringify(ID) + " will be boosted");
            const tx = cds.tx(req);
            await tx.update(POs).with({
                GROSS_AMOUNT: { '+=': 20000 }
            }).where(ID);

            var mydata = tx.read(POs).where(ID);
            return mydata;

        } catch (error) {
            return "Error " + error.toString();
        }
    });

    this.on('largestOrder', async (req, res) => {
        try {
            const tx = cds.tx(req);

            //SELECT * UPTO 1 ROW FROM dbtab ORDER BY GROSS_AMOUNT desc

            const reply = await tx.read(POs).orderBy({
                GROSS_AMOUNT: 'desc'
            }).limit(1);

            return reply;

        } catch (error) {
            return "Error " + error.toString();
        }
    });

    const extendField = (data) => {
        if(data){
            data.map( (record) => {
                if(parseInt(record.TAX_AMOUNT) > 500){
                    record.PRIORITY = "HIGH";
                }else{
                    record.PRIORITY = "LOW";
                }
            });
        }
    }
 
    this.after('READ', POs, (data) => {
        extendField(data);
    });

});