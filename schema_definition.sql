CREATE SCHEMA content_management;

-- Dar permisos más específicos sobre el esquema
GRANT USAGE ON SCHEMA content_management TO arepitauwu;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA content_management TO arepitauwu;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA content_management TO arepitauwu;

CREATE TABLE person(
    id_person   INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name_person VARCHAR(50) NOT NULL,
    second_name_person VARCHAR(50) NOT NULL,
    nationality VARCHAR(18) NOT NULL
); 

--
CREATE TYPE rol AS ENUM ('admin', 'superadmin', 'user');
CREATE TYPE status_of_user AS ENUM ('active', 'block', 'inactive');

--
CREATE TABLE user_app(
    id_user_app INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name_user_app VARCHAR(16) UNIQUE NOT NULL,
    rol_user_app rol  NOT NULL,
    email_user_app VARCHAR(120)  NOT NULL,
    password_hash VARCHAR(255) UNIQUE NOT NULL,
    status_user status_of_user NOT NULL,
    id_person INT,
    FOREIGN KEY (id_person) REFERENCES person (id_person)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);
CREATE TABLE user_app_tracking(
    id_user_app_tracking  INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    type_event VARCHAR(18) NOT NULL,
    date_creation TIMESTAMP DEFAULT NOW(),
    date_update TIMESTAMP ,
    id_user_app INT,
    FOREIGN KEY (id_user_app) REFERENCES user_app (id_user_app) 
    ON DELETE SET NULL 
    ON UPDATE CASCADE
);

CREATE TYPE status_level AS ENUM ('low', 'mid', 'high');
CREATE TYPE status_of_permission AS ENUM ('DESACTIVATE', 'ACTIVE');

CREATE TABLE permission(
    id_permission  INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name_permission VARCHAR(18) UNIQUE NOT NULL,
    level_permission status_level  NOT NULL,
    status_permission status_of_permission DEFAULT 'DESACTIVATE' NOT NULL,
    information_permission VARCHAR(120) NOT NULL
);

CREATE TABLE category(
    id_category INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name_category VARCHAR(24) UNIQUE NOT NULL,
    descriptor_category VARCHAR(60) NOT NULL
);
CREATE TABLE course(
    id_course INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name_course VARCHAR(50) UNIQUE NOT NULL,
    descriptor_course VARCHAR(120) NOT  NULL,
    id_category int,
    FOREIGN KEY (id_category) REFERENCES category (id_category)
    ON DELETE SET NULL 
    ON UPDATE CASCADE
);
Create TABLE user_app_content_information(
    id_user_app_content_information  INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_user_app_tracking INT,
    id_content_information INT,
    FOREIGN KEY (id_user_app_tracking) REFERENCES user_app_tracking (id_user_app_tracking)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
    FOREIGN KEY (id_content_information) REFERENCES content_information (id_content_information)
    ON DELETE SET NULL
    ON UPDATE CASCADE 
);
CREATE TABLE content_information(
    id_content_information  INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    url_content_information VARCHAR(500) NOT NULL,
    name_content VARCHAR(50) NOT NULL,
    id_course INT,
    FOREIGN KEY (id_course) REFERENCES course(id_course)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);
CREATE TABLE user_permission(
    id_user_app_permission INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_user_app_tracking INT,
    id_permission INT,
    FOREIGN KEY (id_user_app_tracking) REFERENCES user_app_tracking (id_user_app_tracking) 
    ON DELETE SET NULL
    ON UPDATE CASCADE,
    FOREIGN KEY (id_permission) REFERENCES permission (id_permission)
    ON DELETE SET NULL
    ON UPDATE CASCADE 
);

