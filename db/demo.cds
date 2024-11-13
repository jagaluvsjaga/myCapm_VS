namespace spiderman;

using {myFirstCapm.commons as commons} from './commons';
using {
    cuid,
    temporal,
    managed
} from '@sap/cds/common';

context master {
    entity student : commons.address {
        key id        : commons.Guid;
            firstName : String(80);
            lastName  : String(80);
            age       : Int16;
            class     : Association to one standard;
    }

    entity standard {
        key id             : commons.Guid;
            semester       : Integer;
            specialization : String(80);
            hod            : String(80);
    }

    entity books {
        key id       : commons.Guid;
            bookName : localized String(80);
            author   : String(32);
    }
}

context transaction {

    entity subs : cuid, temporal, managed {
        book    : Association to one master.books;
        student : Association to one master.student;
    }

}
