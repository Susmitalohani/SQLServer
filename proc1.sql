--simple hospital management system stored procedure
CREATE PROC [dbo].[PR_patient]
    @patient_id INT=NULL,
    @name VARCHAR(50)=NULL,
    @age INT=NULL,
    @address VARCHAR(50)=NULL,
    @gender VARCHAR(10)=NULL,
    @disease VARCHAR(50)=NULL,
    @doctor_id INT=NULL,
    @room_no INT=NULL,
    @bed_id INT=NULL,
    @bill_id INT=NULL,
    @ifPatient INT=NULL,
    @flag VARCHAR(1)=NULL
AS
BEGIN
    IF @flag = 'i'
    BEGIN

        IF @doctor_id NOT IN
           (
               SELECT doctor_id FROM doctor
           )
        BEGIN
            PRINT 'please enter valid doctor_id';
            RETURN;
        END;

        IF @room_no NOT IN
           (
               SELECT room_no FROM room
           )
        BEGIN
            PRINT 'please enter valid room_no';
            RETURN;
        END;
        IF @bed_id NOT IN
           (
               SELECT bed_id FROM bed
           )
        BEGIN
            PRINT 'please enter valid bed_no';
            RETURN;
        END;


        INSERT INTO patient
        (
            patient_id,
            name,
            age,
            gender,
            address,
            disease,
            doctor_id,
            bill_id,
            room_no,
            bed_id
        )
        VALUES
        (   @patient_id, --patient_id-int
            @name,       --patiemt_name-varchar(50)
            @age,        --patient_age-int
            @gender,     --patient_gender varchar(10)
            @address,    --patient_address varchar(10)
            @disease,    --patient_diasease-varchar(50)
            @doctor_id,  --doctor_id-int
            @bill_id,    --doctor_id-int
            @room_no,    --room_no-int 
            @bed_id      --bed_id-int

            );
		END;

        IF @flag = 'U'
        BEGIN
            IF @doctor_id NOT IN
               (
                   SELECT doctor_id FROM doctor
               )
            BEGIN
                PRINT 'please enter valid doctor_id';
                RETURN;
            END;
            IF @bill_id NOT IN
               (
                   SELECT bill_id FROM bill
               )
            BEGIN
                PRINT 'please enter valid bill_id';
                RETURN;
            END;
            IF @bill_id NOT IN
               (
                   SELECT bill_id FROM bill WHERE @patient_id = @patient_id
               )
            BEGIN
                PRINT 'entered bill_id is not related to entered patient_id';
                RETURN;
            END;
            IF @room_no NOT IN
               (
                   SELECT room_no FROM room
               )
            BEGIN
                PRINT 'please enter valid room_no';
                RETURN;
            END;
            IF @bed_id NOT IN
               (
                   SELECT bed_id FROM bed
               )
            BEGIN
                PRINT 'please enter valid bed_no';
                RETURN;
            END;

            UPDATE patient
            SET patient_id = @patient_id,
                name = @name,
                age = @age,
                gender = @gender,
                address = @address,
                disease = @disease,
                doctor_id = @doctor_id,
                bill_id = @bill_id,
                bed_id = @bed_id,
                room_no = @room_no
            WHERE patient_id = @ifPatient;
        END;


        IF @flag = 'd'
        BEGIN
            DELETE FROM patient
            WHERE patient_id = @ifPatient;
        END;

        IF @flag = 's'
        BEGIN
            SELECT p.patient_id,
                   p.name,
                   p.age,
                   p.gender,
                   p.address,
                   p.disease,
                   d.doctor_id,
                   b.bill_id,
                   r.room_no,
                   be.bed_id
            FROM patient p
                LEFT JOIN doctor d
                    ON p.doctor_id = d.doctor_id
                LEFT JOIN bill b
                    ON p.bill_id = b.bill_id
                LEFT JOIN bed be
                    ON p.bed_id = be.bed_id
                LEFT JOIN room r
                    ON p.room_no = r.room_no;
        END;
    
END;

EXEC dbo.PR_patient  @patient_id=,-- int
                    @name = 'sjkhfu',      -- varchar(50)
                    @age = 7,        -- int
                    @address = 'uyfh',   -- varchar(50)
                    @gender = 'femal',    -- varchar(10)
                    @disease = 'isfh',   -- varchar(50)
                    @doctor_id = 5,  -- int
                    @room_no = 202,    -- int
                    @bed_id = 2015,     -- int
                    @bill_id = 109,    -- int
                    @ifPatient = 0,  -- int
                    @flag = 'i'       -- varchar(1)

EXEC dbo.PR_patient @flag = 's'       -- varchar(1)
