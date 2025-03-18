CREATE TABLE vehicles (
    id SERIAL PRIMARY KEY,
    make VARCHAR(255) NOT NULL,
    model VARCHAR(255) NOT NULL,
    registration_number VARCHAR(255) NOT NULL,
    capacity INTEGER NOT NULL,
    year_of_purchase INTEGER NOT NULL,
    total_kms_driven INTEGER NOT NULL,
    last_serviced_on DATE NOT NULL,
    current_mileage INTEGER NOT NULL,
    insurance_valid_until DATE NOT NULL,
    current_status VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);
-- vehicles.current_status: 'enum: on_job, available, under_maintenance, inactice';

CREATE TABLE drivers (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    phone_number VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    permanent_address TEXT NOT NULL,
    license_number VARCHAR(255) NOT NULL,
    license_valid_until DATE NOT NULL,
    primary_alert VARCHAR(255) NOT NULL DEFAULT 'email',
    is_available BOOLEAN NOT NULL,
    is_active BOOLEAN NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);
-- drivers.primary_alert: 'enum: email, sms, push';

CREATE TABLE admin (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    phone_number VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    is_active BOOLEAN NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE dispatcher (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    phone_number VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    primary_alert VARCHAR(255) NOT NULL DEFAULT 'email',
    is_active BOOLEAN NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);
-- dispatcher.primary_alert: 'enum: email, sms, push';

CREATE TABLE jobs (
    id SERIAL PRIMARY KEY,
    vehicle_id INTEGER NOT NULL,
    driver_id INTEGER NOT NULL,
    start_location TEXT NOT NULL,
    end_location TEXT NOT NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,    
    is_delayed BOOLEAN NOT NULL DEFAULT FALSE,
    status VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);
-- jobs.status: 'enum: scheduled, in_progress, completed, cancelled';

CREATE TABLE live_location (
    id SERIAL PRIMARY KEY,
    vehicle_id INTEGER NOT NULL,
    job_id INTEGER NULL,
    latitude FLOAT NOT NULL,
    longitude FLOAT NOT NULL,
    recorded_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE fuel_usage (
    id SERIAL PRIMARY KEY,
    vehicle_id INTEGER NOT NULL,
    job_id INTEGER NULL,
    fuel_filled FLOAT NOT NULL,
    fuel_cost FLOAT NOT NULL,
    bill_proof TEXT NOT NULL,
    odo_reading INTEGER NOT NULL,
    recorded_at TIMESTAMP NOT NULL DEFAULT NOW()
);
-- fuel_usage.bill_proof: 'path of the bill image';

CREATE TABLE notifications (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    job_id INTEGER NULL,
    channel VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,
    is_read BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);
-- notifications.channel: 'enum: email, sms, push';

CREATE TABLE settings (
    id SERIAL PRIMARY KEY,
    key VARCHAR(255) NOT NULL,
    value TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);