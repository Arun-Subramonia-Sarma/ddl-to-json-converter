-- ================================
-- DATABASE CREATION
-- ================================
-- CREATE DATABASE trailer_management_system;
-- USE trailer_management_system;

-- ================================
-- MASTER DATA ENTITIES
-- ================================

-- Facility Master
CREATE TABLE facility_master (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER,
    facility_code VARCHAR(255),
    facility_master_id VARCHAR(255),
    facility_name VARCHAR(255),
    archived BOOLEAN DEFAULT FALSE,
    deleted BOOLEAN DEFAULT FALSE,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant)
);

-- Users Master
CREATE TABLE users_master (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    type VARCHAR(255),
    email_address VARCHAR(255),
    archived BOOLEAN DEFAULT FALSE,
    keycloak_id INTEGER,
    role VARCHAR(255),
    user_session_history_id INTEGER,
    deleted BOOLEAN DEFAULT FALSE,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant)
);

-- Carrier Master
CREATE TABLE carrier_master (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER,
    carrier_code VARCHAR(255),
    carrier_name VARCHAR(255),
    parent_carrier_master_id INTEGER,
    deleted BOOLEAN DEFAULT FALSE,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant)
);

-- Trailer Types Master
CREATE TABLE trailer_types_master (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER,
    name VARCHAR(255),
    referigerated BOOLEAN DEFAULT FALSE,
    archived BOOLEAN DEFAULT FALSE,
    is_swing_door BOOLEAN DEFAULT FALSE,
    deleted BOOLEAN DEFAULT FALSE,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant)
);

-- Tag Types Master
CREATE TABLE tag_types_master (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER,
    name VARCHAR(255),
    archived BOOLEAN DEFAULT FALSE,
    prefix VARCHAR(255),
    default_tag BOOLEAN DEFAULT FALSE,
    range_min VARCHAR(255),
    range_max VARCHAR(255),
    deleted BOOLEAN DEFAULT FALSE,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant)
);

-- Customers Master
CREATE TABLE customers_master (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER,
    name VARCHAR(255),
    active BOOLEAN DEFAULT TRUE,
    customer_permalink VARCHAR(255),
    deleted BOOLEAN DEFAULT FALSE,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant)
);

-- Geofence Master
CREATE TABLE geofence_master (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER,
    facility_master_id INTEGER,
    type VARCHAR(255),
    location FLOAT8[],
    boundary FLOAT8[],
    archived BOOLEAN DEFAULT FALSE,
    deleted BOOLEAN DEFAULT FALSE,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant)
);

-- Zones Master
CREATE TABLE zones_master (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER,
    facility_master_id INTEGER,
    name VARCHAR(255),
    description VARCHAR(255),
    geofence_master_id INTEGER,
    archived BOOLEAN DEFAULT FALSE,
    clean_up BOOLEAN DEFAULT FALSE,
    deleted BOOLEAN DEFAULT FALSE,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant)
);

-- Detention Rates Master
CREATE TABLE detention_rates_master (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER,
    carrier_master_id INTEGER,
    trailer_type_id INTEGER,
    detention_rates_history_id INTEGER,
    deleted BOOLEAN DEFAULT FALSE,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant)
);

-- ================================
-- USER RELATED TABLES
-- ================================

-- User Session History
CREATE TABLE user_session_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    login_time TIMESTAMP,
    logout_time TIMESTAMP,
    user_id INTEGER,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- User Site
CREATE TABLE user_site (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER,
    user_id INTEGER,
    facility_master_id INTEGER,
    enabled BOOLEAN DEFAULT TRUE,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant)
);

-- Saved Filters Master
CREATE TABLE saved_filters_master (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER,
    saved_filter JSONB,
    user_id INTEGER,
    facility_master_id INTEGER,
    deleted BOOLEAN DEFAULT FALSE,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant)
);

-- ================================
-- TRAILER MANAGEMENT ENTITIES
-- ================================

-- Trailers
CREATE TABLE trailers (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER,
    facility_master_id INTEGER,
    check_in_time TIMESTAMP,
    check_out_time TIMESTAMP,
    last_updated_by INTEGER,
    trailer_state_history_id INTEGER,
    trailer_location_history_id INTEGER,
    trailer_attributes_history_id INTEGER,
    trailer_rfid_detail_history_id INTEGER,
    trailer_detention_history_id INTEGER,
    trailer_load_status_history_id INTEGER,
    trailer_seal_status_history_id INTEGER,
    trailer_process_status_history_id INTEGER,
    trailer_shipment_association_history_id INTEGER,
    trailer_expected_ob_shipments_association_history_id INTEGER,
    trailer_prodcut_protection_referigeration_check_history_id INTEGER,
    trailer_prodcut_protection_fuel_level_check_history_id INTEGER,
    trailer_prodcut_protection_mode_of_operation_check_history_id INTEGER,
    trailer_comments_history_id INTEGER,
    trailer_reserved_for_driver_pickup_history_id INTEGER,
    trailer_inventory_update_history_id INTEGER,
    trailer_ctpat_info_history_id INTEGER,
    trailer_intermodal_origin_time_history_id INTEGER,
    trailer_empty_pickup_history_id INTEGER,
    trailer_preffered_location_history_id INTEGER,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant)
);

-- ================================
-- TRAILER HISTORY ENTITIES
-- ================================

-- Trailer State History
CREATE TABLE trailer_state_history (
    id BIGINT NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    facility_master_id INTEGER,
    trailer_id BIGINT,
    damaged BOOLEAN DEFAULT FALSE,
    out_of_service BOOLEAN DEFAULT FALSE,
    audit BOOLEAN DEFAULT FALSE,
    condition VARCHAR(255),
    damaged_notes VARCHAR(255),
    out_of_service_notes VARCHAR(255),
    audit_notes VARCHAR(255),
    trailer_state_timestamp TIMESTAMP,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- Trailer Location History
CREATE TABLE trailer_location_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    location_id INTEGER,
    facility_master_id INTEGER,
    trailer_id INTEGER,
    location_status_time TIMESTAMP,
    location_info VARCHAR(255) CHECK (location_info IN ('At_Gate', 'In_Door', 'In_Spot', 'In_Transit', 'Out_Gate')),
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- Trailer Attributes History
CREATE TABLE trailer_attributes_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    facility_master_id INTEGER,
    trailer_id INTEGER,
    broker_id INTEGER,
    site_owner_id INTEGER,
    carrier_master_id INTEGER,
    trailer_type_id INTEGER,
    trailer_number VARCHAR(255),
    device_number VARCHAR(255),
    trailer_attributes JSONB,
    yusen_tag_id VARCHAR(255),
    external_id VARCHAR(255),
    external_id_source VARCHAR(255),
    load_type VARCHAR(255),
    usage VARCHAR(255),
    attribute_update_time TIMESTAMP,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- Trailer RFID Detail History
CREATE TABLE trailer_rfid_detail_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    facility_master_id INTEGER,
    trailer_id INTEGER,
    tag_type_id INTEGER,
    tag_code VARCHAR(255),
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- Trailer Detention History
CREATE TABLE trailer_detention_history (
    id BIGINT NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    facility_master_id INTEGER,
    trailer_id INTEGER,
    detention_rate_id INTEGER,
    detention_start_time TIMESTAMP,
    detention_end_time TIMESTAMP,
    detention_risk_start_time TIMESTAMP,
    detention_start_event INTEGER,
    detention_end_event INTEGER,
    detention_fees FLOAT,
    detention_rule VARCHAR(255),
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- Trailer Load Status History
CREATE TABLE trailer_load_status_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    trailer_id INTEGER,
    facility_master_id INTEGER,
    load_status VARCHAR(255),
    load_status_time TIMESTAMP,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- Trailer Seal Status History
CREATE TABLE trailer_seal_status_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    trailer_id INTEGER,
    facility_master_id INTEGER,
    seal VARCHAR(255),
    seal_status VARCHAR(255),
    seal_status_time TIMESTAMP,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- Trailer Process Status History
CREATE TABLE trailer_process_status_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    trailer_id INTEGER,
    process_status VARCHAR(255),
    process_status_time TIMESTAMP,
    facility_master_id INTEGER,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- Trailer Shipments Association History
CREATE TABLE trailer_shipments_association_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    facility_master_id INTEGER,
    trailer_id INTEGER,
    shipment_id INTEGER,
    trailer_shipment_association_id INTEGER,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- Trailer Expected OB Shipments Association History
CREATE TABLE trailer_expected_ob_shipments_association_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    facility_master_id INTEGER,
    trailer_id INTEGER,
    shipment_id INTEGER,
    trailer_shipment_association_id INTEGER,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- Trailer Product Protection Refrigeration Check History
CREATE TABLE trailer_prodcut_protection_referigeration_check_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    facility_master_id INTEGER,
    trailer_id INTEGER,
    source VARCHAR(255),
    referigeration_status VARCHAR(255) CHECK (referigeration_status IN ('Not_Available', 'Off', 'Pre_Cooling', 'Active', 'Defrost')),
    temperature FLOAT,
    temperature_set_point FLOAT,
    temperature_range_min FLOAT,
    temperature_range_max FLOAT,
    temperature_display_unit VARCHAR(255) CHECK (temperature_display_unit IN ('Celsius', 'Fahrenheit')),
    temperature_checked BOOLEAN DEFAULT FALSE,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- Trailer Product Protection Fuel Level Check History
CREATE TABLE trailer_prodcut_protection_fuel_level_check_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    facility_master_id INTEGER,
    trailer_id INTEGER,
    source VARCHAR(255),
    fuel_level FLOAT,
    fuel_level_checked BOOLEAN DEFAULT FALSE,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- Trailer Product Protection Mode of Operation Check History
CREATE TABLE trailer_prodcut_protection_mode_of_operation_check_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    facility_master_id INTEGER,
    trailer_id INTEGER,
    mode_of_operation VARCHAR(255),
    source VARCHAR(255),
    mode_of_operation_checked BOOLEAN DEFAULT FALSE,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- Trailer Comments History
CREATE TABLE trailer_comments_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    facility_master_id INTEGER,
    trailer_id INTEGER,
    comments VARCHAR(255),
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- Trailer Reserved for Driver Pickup History
CREATE TABLE trailer_reserved_for_driver_pickup_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    facility_master_id INTEGER,
    trailer_id INTEGER,
    trailer_reserved_for_driver_pickup BOOLEAN DEFAULT FALSE,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- Trailer Inventory Update History
CREATE TABLE trailer_inventory_update_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    facility_master_id INTEGER,
    trailer_id INTEGER,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- Trailer CTPAT Info History
CREATE TABLE trailer_ctpat_info_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    facility_master_id INTEGER,
    trailer_id INTEGER,
    ctpat_info JSONB,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- Trailer Intermodal Origin Time History
CREATE TABLE trailer_intermodal_origin_time_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    facility_master_id INTEGER,
    trailer_id INTEGER,
    intermodal_origin_time TIMESTAMP,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- Trailer Empty Pickup History
CREATE TABLE trailer_empty_pickup_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    facility_master_id INTEGER,
    trailer_id INTEGER,
    empty_pickup BOOLEAN DEFAULT FALSE,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- Trailer Preferred Location History
CREATE TABLE trailer_preffered_location_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    facility_master_id INTEGER,
    trailer_id INTEGER,
    preffered_location_group_ids INTEGER[],
    preffered_location_ids INTEGER[],
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- ================================
-- LOCATION ENTITIES
-- ================================

-- Location Groups
CREATE TABLE location_groups (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER,
    facility_master_id INTEGER,
    geofence_master_id INTEGER,
    name VARCHAR(255),
    capacity INTEGER,
    zone_id INTEGER,
    archived BOOLEAN DEFAULT FALSE,
    deleted BOOLEAN DEFAULT FALSE,
    type VARCHAR(255) CHECK (type IN ('Dock', 'Lot', 'Gate')),
    gate_function VARCHAR(255),
    gate_code VARCHAR(255),
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant)
);

-- Locations
CREATE TABLE locations (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER,
    facility_master_id INTEGER,
    location_group_id INTEGER,
    location_trailer_history_id INTEGER,
    geofence_master_id INTEGER,
    zone_id INTEGER,
    type VARCHAR(255) CHECK (type IN ('Door', 'Spot', 'Lane')),
    name VARCHAR(255),
    archived BOOLEAN DEFAULT FALSE,
    disabled BOOLEAN DEFAULT FALSE,
    reserved BOOLEAN DEFAULT FALSE,
    occupied BOOLEAN DEFAULT FALSE,
    capacity INTEGER,
    building_code VARCHAR(255),
    deleted BOOLEAN DEFAULT FALSE,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant)
);

-- Location Trailer History
CREATE TABLE location_trailer_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    facility_master_id INTEGER,
    trailer_id INTEGER,
    location_id INTEGER,
    in_time TIMESTAMP,
    out_time TIMESTAMP,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- Unpainted Lot Trailer Info
CREATE TABLE unpainted_lot_trailer_info (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER,
    facility_master_id INTEGER,
    location_id INTEGER,
    trailer_id INTEGER,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant)
);

-- Location Queue
CREATE TABLE location_queue (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER,
    location_id INTEGER,
    location_queue_history_id INTEGER,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant)
);

-- Location Queue History
CREATE TABLE location_queue_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    location_id INTEGER,
    trailer_id INTEGER,
    user_id INTEGER,
    task_id INTEGER,
    position INTEGER,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- ================================
-- TASK MANAGEMENT ENTITIES
-- ================================

-- Tasks
CREATE TABLE tasks (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER,
    type VARCHAR(255),
    source_type VARCHAR(255),
    cancellation_reason VARCHAR(255),
    facility_master_id INTEGER,
    tasks_status_history_id INTEGER,
    tasks_trailer_history_id INTEGER,
    requestor_id INTEGER,
    task_priority_history_id INTEGER,
    tasks_assignment_history_id INTEGER,
    move_tasks_details_history_id INTEGER,
    tasks_assignee_comments_history_id INTEGER,
    tasks_requestor_comments_history_id INTEGER,
    refuel_tasks_details_history_id INTEGER,
    precool_tasks_details_history_id INTEGER,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant)
);

-- Tasks Status History
CREATE TABLE tasks_status_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    facility_master_id INTEGER,
    task_id INTEGER,
    status VARCHAR(255),
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- Tasks Trailer History
CREATE TABLE tasks_trailer_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    facility_master_id INTEGER,
    task_id INTEGER,
    trailer_id INTEGER,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- Tasks Priority History
CREATE TABLE tasks_priority_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    facility_master_id INTEGER,
    task_id INTEGER,
    priority VARCHAR(255),
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- Tasks Assignment History
CREATE TABLE tasks_assignment_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    facility_master_id INTEGER,
    task_id INTEGER,
    assignee_id INTEGER,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- Move Tasks Details History
CREATE TABLE move_tasks_details_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    facility_master_id INTEGER,
    task_id INTEGER,
    to_location_id INTEGER,
    from_location_id INTEGER,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- Precool Tasks Details History
CREATE TABLE precool_tasks_details_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    facility_master_id INTEGER,
    task_id INTEGER,
    temperature_set_point FLOAT,
    temperature_display_unit VARCHAR(255),
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- Refuel Tasks Details History
CREATE TABLE refuel_tasks_details_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    facility_master_id INTEGER,
    task_id INTEGER,
    fuel_level FLOAT,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- Tasks Assignee Comments History
CREATE TABLE tasks_assignee_comments_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    facility_master_id INTEGER,
    task_id INTEGER,
    assignee_id INTEGER,
    assignee_comments VARCHAR(255),
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- Tasks Requestor Comments History
CREATE TABLE tasks_requestor_comments_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    facility_master_id INTEGER,
    task_id INTEGER,
    requestor_id INTEGER,
    requestor_comments VARCHAR(255),
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- Tasks Notes History
CREATE TABLE tasks_notes_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    facility_master_id INTEGER,
    task_id INTEGER,
    notes VARCHAR(255),
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- ================================
-- SHIPMENT MANAGEMENT ENTITIES
-- ================================

-- Shipments
CREATE TABLE shipments (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER,
    facility_master_id INTEGER,
    origin_facility_master_id INTEGER,
    destination_facility_master_id INTEGER,
    actual_appointment_time TIMESTAMP,
    carrier_master_id INTEGER,
    trailer_id INTEGER,
    shipment_processed_history_id INTEGER,
    shipment_refernce_number_history INTEGER,
    scheduled_appointment_time_history_id INTEGER,
    shipment_priority_history_id INTEGER,
    shipment_details_history_id INTEGER,
    shipment_estimated_arrival_time_history_id INTEGER,
    shipment_last_associated_trailer_history_id INTEGER,
    shipment_canceled_history_id INTEGER,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant)
);

-- Shipment Last Associated Trailer History
CREATE TABLE shipment_last_associated_trailer_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    shipment_id INTEGER,
    facility_master_id INTEGER,
    last_associated_trailer_id INTEGER,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- Shipment Details History
CREATE TABLE shipment_details_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    shipment_id INTEGER,
    facility_master_id INTEGER,
    shipment_name VARCHAR(255),
    direction VARCHAR(255) CHECK (direction IN ('Inbound', 'Outbound')),
    actual_load_mode VARCHAR(255),
    tms_id VARCHAR(255),
    tms_source VARCHAR(255),
    customer_id INTEGER,
    safety_check VARCHAR(255),
    safety_check_time TIMESTAMP,
    external_url VARCHAR(255),
    want_time TIMESTAMP,
    source VARCHAR(255) CHECK (source IN ('AM', 'CORE_TRAC', 'DY')),
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- Shipment Canceled History
CREATE TABLE shipment_canceled_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    shipment_id INTEGER,
    facility_master_id INTEGER,
    canceled BOOLEAN DEFAULT FALSE,
    source VARCHAR(255) CHECK (source IN ('AM', 'CORE_TRAC', 'DY')),
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- Shipment Scheduled Details History
CREATE TABLE shipment_scheduled_details_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    shipment_id INTEGER,
    facility_master_id INTEGER,
    expected_seal_number VARCHAR(255),
    scheduled_carrier_id INTEGER,
    scheduled_trailer_name VARCHAR(255),
    scheduled_trailer_type_id INTEGER,
    expected_seal_status VARCHAR(255),
    expected_broker_id INTEGER,
    source VARCHAR(255) CHECK (source IN ('AM', 'CORE_TRAC', 'DY')),
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- Shipment Reference Number History
CREATE TABLE shipment_refernce_number_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    shipment_id INTEGER,
    facility_master_id INTEGER,
    source VARCHAR(255) CHECK (source IN ('AM', 'CORE_TRAC', 'DY')),
    route_id VARCHAR(255),
    bill_of_lading VARCHAR(255),
    po_numbers VARCHAR(255),
    reference_numbers VARCHAR(255),
    load_reference_numbers VARCHAR(255),
    tags VARCHAR(255),
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- Scheduled Appointment Time History
CREATE TABLE scheduled_appointment_time_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    shipment_id INTEGER,
    facility_master_id INTEGER,
    appointment_start_time TIMESTAMP,
    appointment_end_time TIMESTAMP,
    source VARCHAR(255) CHECK (source IN ('DY', 'AM', 'CORE_TRAC')),
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- Shipment Estimated Arrival Time History
CREATE TABLE shipment_estimated_arrival_time_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    shipment_id INTEGER,
    facility_master_id INTEGER,
    estimated_arrival_time TIMESTAMP,
    source VARCHAR(255) CHECK (source IN ('DY', 'AM', 'CORE_TRAC')),
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- Shipment Processed History
CREATE TABLE shipment_processed_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    shipment_id INTEGER,
    facility_master_id INTEGER,
    processed BOOLEAN DEFAULT FALSE,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- Shipment Priority History
CREATE TABLE shipment_priority_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    facility_master_id INTEGER,
    shipment_id INTEGER,
    priority VARCHAR(255),
    source VARCHAR(255) CHECK (source IN ('AM', 'CORE_TRAC', 'DY')),
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- ================================
-- DETENTION HISTORY
-- ================================

-- Detention Rates History
CREATE TABLE detention_rates_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    detention_rate_id INTEGER,
    detention_rate FLOAT,
    charge_interval INTEGER,
    charge_interval_units VARCHAR(255),
    type VARCHAR(255),
    intermodal BOOLEAN DEFAULT FALSE,
    max_fee FLOAT,
    free_time INTEGER,
    free_time_units VARCHAR(255),
    ob_end_event VARCHAR(255),
    ob_start_event VARCHAR(255),
    start_event VARCHAR(255),
    end_event VARCHAR(255),
    origin_return_calc_method VARCHAR(255),
    archived BOOLEAN DEFAULT FALSE,
    disabled BOOLEAN DEFAULT FALSE,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- ================================
-- OTHER OPERATIONAL ENTITIES
-- ================================

-- Carrier Sites
CREATE TABLE carrier_sites (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER,
    carrier_master_id INTEGER,
    facility_master_id INTEGER,
    enabled BOOLEAN DEFAULT TRUE,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant)
);

-- Tractors
CREATE TABLE tractors (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    facility_master_id INTEGER,
    carrier_master_id INTEGER,
    version INTEGER,
    tractor_number VARCHAR(255),
    license_plate VARCHAR(255),
    tractor_state VARCHAR(255),
    tractor_country VARCHAR(255),
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant)
);

-- Drivers
CREATE TABLE drivers (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER,
    driver_name VARCHAR(255),
    driver_phone VARCHAR(255),
    driver_license_number VARCHAR(255),
    created_by INTEGER,
    updated_by INTEGER,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id, tenant)
);

-- Gate Operations
CREATE TABLE gate_operations (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER,
    gate_operation_type VARCHAR(255) CHECK (gate_operation_type IN ('Check_In', 'Check_Out', 'Turn_Away')),
    facility_master_id INTEGER,
    trailer_id INTEGER,
    driver_id INTEGER,
    tractor_master_id INTEGER,
    guard_id INTEGER,
    trailer_state_history_id INTEGER,
    location_id INTEGER,
    trailer_attributes_history_id INTEGER,
    trailer_rfid_detail_history_id INTEGER,
    trailer_detention_history_id INTEGER,
    trailer_load_status_history_id INTEGER,
    trailer_seal_status_history_id INTEGER,
    trailer_process_status_history_id INTEGER,
    trailer_shipment_association_history_id INTEGER,
    trailer_expected_ob_shipments_association_history_id INTEGER,
    trailer_prodcut_protection_referigeration_check_history_id INTEGER,
    trailer_prodcut_protection_fuel_level_check_history_id INTEGER,
    trailer_prodcut_protection_mode_of_operation_check_history_id INTEGER,
    trailer_comments_history_id INTEGER,
    trailer_reserved_for_driver_pickup_history_id INTEGER,
    trailer_inventory_update_history_id INTEGER,
    trailer_ctpat_info_history_id INTEGER,
    trailer_intermodal_origin_time_history_id INTEGER,
    trailer_empty_pickup_history_id INTEGER,
    appointment_id INTEGER,
    comments VARCHAR(255),
    source VARCHAR(255),
    turnaway_reason_code VARCHAR(255),
    created_by INTEGER,
    updated_by INTEGER,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id, tenant)
);

-- Appointments
CREATE TABLE appointments (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    facility_master_id INTEGER,
    version INTEGER,
    appointment_history_id INTEGER,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant)
);

-- Appointment History
CREATE TABLE appointment_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    facility_master_id INTEGER,
    appointment_id INTEGER,
    inbound_trailer_id INTEGER,
    outbound_trailer_id INTEGER,
    tractor_id INTEGER,
    is_gate_pass_issued BOOLEAN DEFAULT FALSE,
    tms_id VARCHAR(255),
    tms_source VARCHAR(255),
    gp_open_time TIMESTAMP,
    gp_close_time TIMESTAMP,
    gp_close_type VARCHAR(255),
    additional_attributes JSONB,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- ================================
-- SPOTTER MANAGEMENT ENTITIES
-- ================================

-- Spotter Vehicles Master
CREATE TABLE spotter_vehicles_master (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER,
    facility_master_id INTEGER,
    vehicle_number VARCHAR(255),
    vehicle_type VARCHAR(255) CHECK (vehicle_type IN ('Truck', 'Forklift', 'Other')),
    archived BOOLEAN DEFAULT FALSE,
    description VARCHAR(255),
    spotter_vehicle_task_history_id INTEGER,
    spotter_vehicle_location_history_id INTEGER,
    deleted BOOLEAN DEFAULT FALSE,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant)
);

-- Spotter Location History
CREATE TABLE spotter_location_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    facility_master_id INTEGER,
    spotter_vehicle_id INTEGER,
    spotter_id INTEGER,
    location FLOAT8[],
    heading FLOAT,
    speed FLOAT,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- Spotter Task History
CREATE TABLE spotter_task_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    facility_master_id INTEGER,
    spotter_id INTEGER,
    spotter_vehicle_id INTEGER,
    task_id INTEGER,
    trailer_id INTEGER,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- Spotter Teams Master
CREATE TABLE spotter_teams_master (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER,
    facility_master_id INTEGER,
    name VARCHAR(255),
    description VARCHAR(255),
    archived BOOLEAN DEFAULT FALSE,
    deleted BOOLEAN DEFAULT FALSE,
    eligible_location_group_ids INTEGER[],
    eligible_location_ids INTEGER[],
    preffered_location_group_ids INTEGER[],
    preffered_location_ids INTEGER[],
    unassigned_eligible_location_allowed BOOLEAN DEFAULT FALSE,
    unassigned_preffered_location_allowed BOOLEAN DEFAULT FALSE,
    task_types VARCHAR(255)[],
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant)
);

-- Spotter Teams Vehicles
CREATE TABLE spotter_teams_vehicles (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER,
    facility_master_id INTEGER,
    switcher_team_id INTEGER,
    spotter_vehicle_id INTEGER,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant)
);

-- Spotter Team Members
CREATE TABLE spotter_team_members (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER,
    facility_master_id INTEGER,
    switcher_team_id INTEGER,
    spotter_id INTEGER,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant)
);

-- Spotter Queue
CREATE TABLE spotter_queue (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER,
    facility_master_id INTEGER,
    spotter_id INTEGER,
    spotter_queue_history_id INTEGER,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant)
);

-- Spotter Queue History
CREATE TABLE spotter_queue_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    facility_master_id INTEGER,
    spotter_id INTEGER,
    task_id INTEGER,
    position INTEGER,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- ================================
-- FREIGHT MANAGEMENT ENTITIES
-- ================================

-- Freights Master
CREATE TABLE freights_master (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER,
    freight_code VARCHAR(255),
    type VARCHAR(255),
    description VARCHAR(255),
    name VARCHAR(255),
    additional_attributes JSONB,
    deleted BOOLEAN DEFAULT FALSE,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant)
);

-- Freight Sites
CREATE TABLE freight_sites (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER,
    facility_master_id INTEGER,
    freight_master_id INTEGER,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant)
);

-- Item Bundle
CREATE TABLE item_bundle (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    facility_master_id INTEGER,
    shipment_id INTEGER,
    freight_master_id INTEGER,
    scheduled_quantity INTEGER,
    actual_quantity INTEGER,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant)
);

-- ================================
-- SITE SETTINGS ENTITIES
-- ================================

-- Site Settings Master
CREATE TABLE site_settings_master (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER,
    facility_master_id INTEGER,
    site_settings_history_id INTEGER,
    product_protection_site_settings_history_id INTEGER,
    deleted BOOLEAN DEFAULT FALSE,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant)
);

-- Site Settings History
CREATE TABLE site_settings_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    facility_master_id INTEGER,
    loading_screens JSONB,
    unloading_screens JSONB,
    switcher_inactive_timeout INTEGER,
    auto_assign_move_requests BOOLEAN DEFAULT FALSE,
    product_protection BOOLEAN DEFAULT FALSE,
    use_proximity BOOLEAN DEFAULT FALSE,
    stale_threshold_minutes BOOLEAN DEFAULT FALSE,
    allow_OOS_move_requests BOOLEAN DEFAULT FALSE,
    emergency_message_duration_minutes INTEGER,
    switcher_app_config JSONB,
    drive_by_config JSONB,
    rfid_reader_config JSONB,
    trailers_at_risk_time_interval INTEGER,
    table_properties JSONB,
    trailer_name_max_length INTEGER,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- Product Protection Site Settings History
CREATE TABLE product_protection_site_settings_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    facility_master_id INTEGER,
    lot_enabled BOOLEAN DEFAULT FALSE,
    dock_enabled BOOLEAN DEFAULT FALSE,
    default_check_timeout INTEGER,
    default_warning_threshold INTEGER,
    default_alert_threshold INTEGER,
    defrost_check_timeout INTEGER,
    defrost_warning_threshold INTEGER,
    defrost_alert_threshold INTEGER,
    auto_trigger BOOLEAN DEFAULT FALSE,
    auto_trigger_interval INTEGER,
    automated_refuel_task_enabled BOOLEAN DEFAULT FALSE,
    minimum_fuel_level FLOAT,
    refill_level FLOAT,
    both_varience_enabled BOOLEAN DEFAULT FALSE,
    mode_of_operation_enabled BOOLEAN DEFAULT FALSE,
    fuel_level_required BOOLEAN DEFAULT FALSE,
    load_type VARCHAR(255),
    minimum_temperature FLOAT,
    maximum_temperature FLOAT,
    temperature_set_point FLOAT,
    temperature_display_unit VARCHAR(255),
    disabled BOOLEAN DEFAULT FALSE,
    lower_variance FLOAT,
    upper_variance FLOAT,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- ================================
-- RULES ENGINE ENTITIES
-- ================================

-- Location Assignment Rules Master
CREATE TABLE location_assignment_rules_master (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER,
    facility_master_id INTEGER,
    name VARCHAR(255),
    description VARCHAR(255),
    conditions JSONB,
    priority INTEGER,
    eligible_location_group_ids INTEGER[],
    eligible_location_ids INTEGER[],
    archived BOOLEAN DEFAULT FALSE,
    deleted BOOLEAN DEFAULT FALSE,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant)
);

-- Automatic Move Request Creation Rules Master
CREATE TABLE automatic_move_request_creation_rules_master (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER,
    facility_master_id INTEGER,
    name VARCHAR(255),
    description VARCHAR(255),
    conditions JSONB,
    priority INTEGER,
    eligible_origin_location_ids INTEGER[],
    eligible_destination_location_ids INTEGER[],
    eligible_origin_location_group_ids INTEGER[],
    eligible_destination_location_group_ids INTEGER[],
    task_priority VARCHAR(255) CHECK (task_priority IN ('Normal', 'Priority', 'Stale')),
    archived BOOLEAN DEFAULT FALSE,
    deleted BOOLEAN DEFAULT FALSE,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant)
);

-- Task Restriction Rules Master
CREATE TABLE task_restriction_rules_master (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER,
    facility_master_id INTEGER,
    name VARCHAR(255),
    description VARCHAR(255),
    conditions JSONB,
    priority INTEGER,
    archived BOOLEAN DEFAULT FALSE,
    deleted BOOLEAN DEFAULT FALSE,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant)
);

-- ================================
-- REPORTING ENTITIES
-- ================================

-- Buildings Master
CREATE TABLE buildings_master (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER,
    facility_master_id INTEGER,
    name VARCHAR(255),
    archived BOOLEAN DEFAULT FALSE,
    geofence_master_id INTEGER,
    deleted BOOLEAN DEFAULT FALSE,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant)
);

-- Reports Master
CREATE TABLE reports_master (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER,
    facility_master_id INTEGER,
    name VARCHAR(255),
    template VARCHAR(255),
    columns JSONB,
    filters JSONB,
    shared_with_site_ids INTEGER[],
    is_shared_report BOOLEAN DEFAULT FALSE,
    deleted BOOLEAN DEFAULT FALSE,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant)
);

-- Reports Sites
CREATE TABLE reports_sites (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER,
    facility_master_id INTEGER,
    reports_master_id INTEGER,
    enabled BOOLEAN DEFAULT TRUE,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant)
);

-- Scheduled Report Emails Master
CREATE TABLE scheduled_report_emails_master (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER,
    facility_master_id INTEGER,
    reports_master_id INTEGER,
    name VARCHAR(255),
    email_subject VARCHAR(255),
    data_window_delta INTEGER,
    tz_name VARCHAR(255),
    last_sent_at TIMESTAMP,
    attachment_file_format VARCHAR(255),
    site_ids INTEGER[],
    scheduled_send_frequency VARCHAR(255)[],
    scheduled_email_addresses VARCHAR(255)[],
    deleted BOOLEAN DEFAULT FALSE,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant)
);

-- ================================
-- RFID AND OTHER ENTITIES
-- ================================

-- RFID Tag Reads History
CREATE TABLE rfid_tag_reads_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    facility_master_id INTEGER,
    trailer_id INTEGER,
    closest_location_id INTEGER,
    tag_type_id INTEGER,
    spotter_vehicle_id INTEGER,
    spotter_id INTEGER,
    trailer_location_history_id INTEGER,
    trailer_state_history_id INTEGER,
    trailer_attributes_history_id INTEGER,
    trailer_rfid_detail_history_id INTEGER,
    trailer_detention_history_id INTEGER,
    trailer_load_status_history_id INTEGER,
    trailer_seal_status_history_id INTEGER,
    trailer_process_status_history_id INTEGER,
    trailer_shipments_association_history_id INTEGER,
    trailer_expected_ob_shipments_association_history_id INTEGER,
    trailer_prodcut_protection_referigeration_check_history_id INTEGER,
    trailer_prodcut_protection_fuel_level_check_history_id INTEGER,
    trailer_prodcut_protection_mode_of_operation_check_history_id INTEGER,
    trailer_comments_history_id INTEGER,
    trailer_reserved_for_driver_pickup_history_id INTEGER,
    trailer_inventory_update_history_id INTEGER,
    trailer_ctpat_info_history_id INTEGER,
    trailer_intermodal_origin_time_history_id INTEGER,
    trailer_empty_pickup_history_id INTEGER,
    rfid_read_timestamp TIMESTAMP,
    signal_strength INTEGER,
    rfid VARCHAR(255),
    tag_code VARCHAR(255),
    latitude VARCHAR(255),
    longitude VARCHAR(255),
    heading FLOAT8,
    speed FLOAT8,
    distance_to_closest_location FLOAT8,
    status VARCHAR(255),
    process_comments VARCHAR(255),
    invalid_payload BOOLEAN DEFAULT FALSE,
    post_process_required BOOLEAN DEFAULT FALSE,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- CTPAT Settings Master
CREATE TABLE ctpat_settings_master (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER,
    config JSONB,
    enabled BOOLEAN DEFAULT FALSE,
    mandatory BOOLEAN DEFAULT FALSE,
    deleted BOOLEAN DEFAULT FALSE,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant)
);

-- Trailer Pool Settings Master
CREATE TABLE trailer_pool_settings_master (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER,
    facility_master_id INTEGER,
    carrier_master_id INTEGER,
    min_pool INTEGER,
    max_pool INTEGER,
    additional_attributes JSONB,
    deleted BOOLEAN DEFAULT FALSE,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant)
);

-- Webhooks Config Master
CREATE TABLE webhooks_config_master (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER,
    trigger_event VARCHAR(255),
    url VARCHAR(255),
    name VARCHAR(255),
    description VARCHAR(255),
    authentication_method VARCHAR(255),
    deleted BOOLEAN DEFAULT FALSE,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant)
);

-- Trailer Tags Master
CREATE TABLE trailer_tags_master (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER,
    carrier_master_id INTEGER,
    trailer_type_master_id INTEGER,
    tag_code VARCHAR(255),
    trailer_name VARCHAR(255),
    carrier_id INTEGER,
    additional_attributes JSONB,
    check_in_eligible BOOLEAN DEFAULT TRUE,
    check_out_eligible BOOLEAN DEFAULT TRUE,
    trailer_usage VARCHAR(255),
    archived BOOLEAN DEFAULT FALSE,
    deleted BOOLEAN DEFAULT FALSE,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant)
);

-- Trailer Tags Sites
CREATE TABLE trailer_tags_sites (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER,
    facility_master_id INTEGER,
    trailer_tag_id INTEGER,
    archived BOOLEAN DEFAULT FALSE,
    deleted BOOLEAN DEFAULT FALSE,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant)
);

-- Carrier Eligibility
CREATE TABLE carrier_eligibility (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER,
    facility_master_id INTEGER,
    tractor_carrier_master_id INTEGER,
    trailer_carrier_master_id INTEGER,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant)
);

-- Spotter Vehicle Location History (duplicate name in schema)
CREATE TABLE spotter_vehicle_location_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    facility_master_id INTEGER,
    spotter_vehicle_id INTEGER,
    spotter_id INTEGER,
    location FLOAT8[],
    heading FLOAT,
    speed FLOAT,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);

-- Spotter Vehicle Task History (duplicate name in schema)
CREATE TABLE spotter_vehicle_task_history (
    id INTEGER NOT NULL,
    tenant VARCHAR(255) NOT NULL,
    version INTEGER NOT NULL,
    facility_master_id INTEGER,
    spotter_id INTEGER,
    spotter_vehicle_id INTEGER,
    task_id INTEGER,
    trailer_id INTEGER,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    PRIMARY KEY (id, tenant, version)
);



-- ================================
-- FOREIGN KEY CONSTRAINTS FOR ALL TABLES
-- ================================
-- Note: Some constraints might fail if there are circular dependencies
-- You may need to add them in a specific order or defer some constraints

-- ================================
-- MASTER DATA CONSTRAINTS
-- ================================

-- Users Master (self-referential)
ALTER TABLE users_master ADD CONSTRAINT fk_users_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE users_master ADD CONSTRAINT fk_users_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE users_master ADD CONSTRAINT fk_users_session_history FOREIGN KEY (user_session_history_id, tenant) REFERENCES user_session_history(id, tenant);

-- Facility Master
ALTER TABLE facility_master ADD CONSTRAINT fk_facility_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE facility_master ADD CONSTRAINT fk_facility_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Carrier Master
ALTER TABLE carrier_master ADD CONSTRAINT fk_carrier_parent FOREIGN KEY (parent_carrier_master_id, tenant) REFERENCES carrier_master(id, tenant);
ALTER TABLE carrier_master ADD CONSTRAINT fk_carrier_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE carrier_master ADD CONSTRAINT fk_carrier_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Trailer Types Master
ALTER TABLE trailer_types_master ADD CONSTRAINT fk_trailer_types_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE trailer_types_master ADD CONSTRAINT fk_trailer_types_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Tag Types Master
ALTER TABLE tag_types_master ADD CONSTRAINT fk_tag_types_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE tag_types_master ADD CONSTRAINT fk_tag_types_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Customers Master
ALTER TABLE customers_master ADD CONSTRAINT fk_customers_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE customers_master ADD CONSTRAINT fk_customers_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Geofence Master
ALTER TABLE geofence_master ADD CONSTRAINT fk_geofence_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE geofence_master ADD CONSTRAINT fk_geofence_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE geofence_master ADD CONSTRAINT fk_geofence_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Zones Master
ALTER TABLE zones_master ADD CONSTRAINT fk_zones_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE zones_master ADD CONSTRAINT fk_zones_geofence FOREIGN KEY (geofence_master_id, tenant) REFERENCES geofence_master(id, tenant);
ALTER TABLE zones_master ADD CONSTRAINT fk_zones_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE zones_master ADD CONSTRAINT fk_zones_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Detention Rates Master
ALTER TABLE detention_rates_master ADD CONSTRAINT fk_detention_rates_carrier FOREIGN KEY (carrier_master_id, tenant) REFERENCES carrier_master(id, tenant);
ALTER TABLE detention_rates_master ADD CONSTRAINT fk_detention_rates_trailer_type FOREIGN KEY (trailer_type_id, tenant) REFERENCES trailer_types_master(id, tenant);
ALTER TABLE detention_rates_master ADD CONSTRAINT fk_detention_rates_history FOREIGN KEY (detention_rates_history_id, tenant) REFERENCES detention_rates_history(id, tenant);
ALTER TABLE detention_rates_master ADD CONSTRAINT fk_detention_rates_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE detention_rates_master ADD CONSTRAINT fk_detention_rates_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- ================================
-- USER RELATED CONSTRAINTS
-- ================================

-- User Session History
ALTER TABLE user_session_history ADD CONSTRAINT fk_user_session_user FOREIGN KEY (user_id, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE user_session_history ADD CONSTRAINT fk_user_session_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE user_session_history ADD CONSTRAINT fk_user_session_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- User Site
ALTER TABLE user_site ADD CONSTRAINT fk_user_site_user FOREIGN KEY (user_id, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE user_site ADD CONSTRAINT fk_user_site_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE user_site ADD CONSTRAINT fk_user_site_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE user_site ADD CONSTRAINT fk_user_site_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Saved Filters Master
ALTER TABLE saved_filters_master ADD CONSTRAINT fk_saved_filters_user FOREIGN KEY (user_id, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE saved_filters_master ADD CONSTRAINT fk_saved_filters_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE saved_filters_master ADD CONSTRAINT fk_saved_filters_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE saved_filters_master ADD CONSTRAINT fk_saved_filters_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- ================================
-- TRAILER CONSTRAINTS
-- ================================

-- Trailers (main table)
ALTER TABLE trailers ADD CONSTRAINT fk_trailers_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE trailers ADD CONSTRAINT fk_trailers_last_updated_by FOREIGN KEY (last_updated_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE trailers ADD CONSTRAINT fk_trailers_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE trailers ADD CONSTRAINT fk_trailers_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Note: Constraints to history tables would create circular dependencies
-- These are typically handled at application level

-- ================================
-- TRAILER HISTORY CONSTRAINTS
-- ================================

-- Trailer State History
ALTER TABLE trailer_state_history ADD CONSTRAINT fk_trailer_state_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE trailer_state_history ADD CONSTRAINT fk_trailer_state_trailer FOREIGN KEY (trailer_id, tenant) REFERENCES trailers(id, tenant);
ALTER TABLE trailer_state_history ADD CONSTRAINT fk_trailer_state_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE trailer_state_history ADD CONSTRAINT fk_trailer_state_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Trailer Location History
ALTER TABLE trailer_location_history ADD CONSTRAINT fk_trailer_location_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE trailer_location_history ADD CONSTRAINT fk_trailer_location_trailer FOREIGN KEY (trailer_id, tenant) REFERENCES trailers(id, tenant);
ALTER TABLE trailer_location_history ADD CONSTRAINT fk_trailer_location_location FOREIGN KEY (location_id, tenant) REFERENCES locations(id, tenant);
ALTER TABLE trailer_location_history ADD CONSTRAINT fk_trailer_location_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE trailer_location_history ADD CONSTRAINT fk_trailer_location_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Trailer Attributes History
ALTER TABLE trailer_attributes_history ADD CONSTRAINT fk_trailer_attr_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE trailer_attributes_history ADD CONSTRAINT fk_trailer_attr_trailer FOREIGN KEY (trailer_id, tenant) REFERENCES trailers(id, tenant);
ALTER TABLE trailer_attributes_history ADD CONSTRAINT fk_trailer_attr_broker FOREIGN KEY (broker_id, tenant) REFERENCES carrier_master(id, tenant);
ALTER TABLE trailer_attributes_history ADD CONSTRAINT fk_trailer_attr_site_owner FOREIGN KEY (site_owner_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE trailer_attributes_history ADD CONSTRAINT fk_trailer_attr_carrier FOREIGN KEY (carrier_master_id, tenant) REFERENCES carrier_master(id, tenant);
ALTER TABLE trailer_attributes_history ADD CONSTRAINT fk_trailer_attr_type FOREIGN KEY (trailer_type_id, tenant) REFERENCES trailer_types_master(id, tenant);
ALTER TABLE trailer_attributes_history ADD CONSTRAINT fk_trailer_attr_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE trailer_attributes_history ADD CONSTRAINT fk_trailer_attr_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Trailer RFID Detail History
ALTER TABLE trailer_rfid_detail_history ADD CONSTRAINT fk_trailer_rfid_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE trailer_rfid_detail_history ADD CONSTRAINT fk_trailer_rfid_trailer FOREIGN KEY (trailer_id, tenant) REFERENCES trailers(id, tenant);
ALTER TABLE trailer_rfid_detail_history ADD CONSTRAINT fk_trailer_rfid_tag_type FOREIGN KEY (tag_type_id, tenant) REFERENCES tag_types_master(id, tenant);
ALTER TABLE trailer_rfid_detail_history ADD CONSTRAINT fk_trailer_rfid_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE trailer_rfid_detail_history ADD CONSTRAINT fk_trailer_rfid_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Trailer Detention History
ALTER TABLE trailer_detention_history ADD CONSTRAINT fk_trailer_detention_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE trailer_detention_history ADD CONSTRAINT fk_trailer_detention_trailer FOREIGN KEY (trailer_id, tenant) REFERENCES trailers(id, tenant);
ALTER TABLE trailer_detention_history ADD CONSTRAINT fk_trailer_detention_rate FOREIGN KEY (detention_rate_id, tenant) REFERENCES detention_rates_master(id, tenant);
ALTER TABLE trailer_detention_history ADD CONSTRAINT fk_trailer_detention_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE trailer_detention_history ADD CONSTRAINT fk_trailer_detention_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Trailer Load Status History
ALTER TABLE trailer_load_status_history ADD CONSTRAINT fk_trailer_load_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE trailer_load_status_history ADD CONSTRAINT fk_trailer_load_trailer FOREIGN KEY (trailer_id, tenant) REFERENCES trailers(id, tenant);
ALTER TABLE trailer_load_status_history ADD CONSTRAINT fk_trailer_load_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE trailer_load_status_history ADD CONSTRAINT fk_trailer_load_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Trailer Seal Status History
ALTER TABLE trailer_seal_status_history ADD CONSTRAINT fk_trailer_seal_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE trailer_seal_status_history ADD CONSTRAINT fk_trailer_seal_trailer FOREIGN KEY (trailer_id, tenant) REFERENCES trailers(id, tenant);
ALTER TABLE trailer_seal_status_history ADD CONSTRAINT fk_trailer_seal_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE trailer_seal_status_history ADD CONSTRAINT fk_trailer_seal_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Trailer Process Status History
ALTER TABLE trailer_process_status_history ADD CONSTRAINT fk_trailer_process_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE trailer_process_status_history ADD CONSTRAINT fk_trailer_process_trailer FOREIGN KEY (trailer_id, tenant) REFERENCES trailers(id, tenant);
ALTER TABLE trailer_process_status_history ADD CONSTRAINT fk_trailer_process_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE trailer_process_status_history ADD CONSTRAINT fk_trailer_process_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Trailer Shipments Association History
ALTER TABLE trailer_shipments_association_history ADD CONSTRAINT fk_trailer_ship_assoc_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE trailer_shipments_association_history ADD CONSTRAINT fk_trailer_ship_assoc_trailer FOREIGN KEY (trailer_id, tenant) REFERENCES trailers(id, tenant);
ALTER TABLE trailer_shipments_association_history ADD CONSTRAINT fk_trailer_ship_assoc_shipment FOREIGN KEY (shipment_id, tenant) REFERENCES shipments(id, tenant);
ALTER TABLE trailer_shipments_association_history ADD CONSTRAINT fk_trailer_ship_assoc_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE trailer_shipments_association_history ADD CONSTRAINT fk_trailer_ship_assoc_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Trailer Expected OB Shipments Association History
ALTER TABLE trailer_expected_ob_shipments_association_history ADD CONSTRAINT fk_trailer_exp_ship_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE trailer_expected_ob_shipments_association_history ADD CONSTRAINT fk_trailer_exp_ship_trailer FOREIGN KEY (trailer_id, tenant) REFERENCES trailers(id, tenant);
ALTER TABLE trailer_expected_ob_shipments_association_history ADD CONSTRAINT fk_trailer_exp_ship_shipment FOREIGN KEY (shipment_id, tenant) REFERENCES shipments(id, tenant);
ALTER TABLE trailer_expected_ob_shipments_association_history ADD CONSTRAINT fk_trailer_exp_ship_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE trailer_expected_ob_shipments_association_history ADD CONSTRAINT fk_trailer_exp_ship_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Product Protection History Tables
ALTER TABLE trailer_prodcut_protection_referigeration_check_history ADD CONSTRAINT fk_trailer_pp_ref_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE trailer_prodcut_protection_referigeration_check_history ADD CONSTRAINT fk_trailer_pp_ref_trailer FOREIGN KEY (trailer_id, tenant) REFERENCES trailers(id, tenant);
ALTER TABLE trailer_prodcut_protection_referigeration_check_history ADD CONSTRAINT fk_trailer_pp_ref_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE trailer_prodcut_protection_referigeration_check_history ADD CONSTRAINT fk_trailer_pp_ref_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

ALTER TABLE trailer_prodcut_protection_fuel_level_check_history ADD CONSTRAINT fk_trailer_pp_fuel_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE trailer_prodcut_protection_fuel_level_check_history ADD CONSTRAINT fk_trailer_pp_fuel_trailer FOREIGN KEY (trailer_id, tenant) REFERENCES trailers(id, tenant);
ALTER TABLE trailer_prodcut_protection_fuel_level_check_history ADD CONSTRAINT fk_trailer_pp_fuel_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE trailer_prodcut_protection_fuel_level_check_history ADD CONSTRAINT fk_trailer_pp_fuel_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

ALTER TABLE trailer_prodcut_protection_mode_of_operation_check_history ADD CONSTRAINT fk_trailer_pp_mode_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE trailer_prodcut_protection_mode_of_operation_check_history ADD CONSTRAINT fk_trailer_pp_mode_trailer FOREIGN KEY (trailer_id, tenant) REFERENCES trailers(id, tenant);
ALTER TABLE trailer_prodcut_protection_mode_of_operation_check_history ADD CONSTRAINT fk_trailer_pp_mode_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE trailer_prodcut_protection_mode_of_operation_check_history ADD CONSTRAINT fk_trailer_pp_mode_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Other Trailer History Tables
ALTER TABLE trailer_comments_history ADD CONSTRAINT fk_trailer_comments_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE trailer_comments_history ADD CONSTRAINT fk_trailer_comments_trailer FOREIGN KEY (trailer_id, tenant) REFERENCES trailers(id, tenant);
ALTER TABLE trailer_comments_history ADD CONSTRAINT fk_trailer_comments_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE trailer_comments_history ADD CONSTRAINT fk_trailer_comments_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

ALTER TABLE trailer_reserved_for_driver_pickup_history ADD CONSTRAINT fk_trailer_reserved_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE trailer_reserved_for_driver_pickup_history ADD CONSTRAINT fk_trailer_reserved_trailer FOREIGN KEY (trailer_id, tenant) REFERENCES trailers(id, tenant);
ALTER TABLE trailer_reserved_for_driver_pickup_history ADD CONSTRAINT fk_trailer_reserved_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE trailer_reserved_for_driver_pickup_history ADD CONSTRAINT fk_trailer_reserved_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

ALTER TABLE trailer_inventory_update_history ADD CONSTRAINT fk_trailer_inventory_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE trailer_inventory_update_history ADD CONSTRAINT fk_trailer_inventory_trailer FOREIGN KEY (trailer_id, tenant) REFERENCES trailers(id, tenant);
ALTER TABLE trailer_inventory_update_history ADD CONSTRAINT fk_trailer_inventory_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE trailer_inventory_update_history ADD CONSTRAINT fk_trailer_inventory_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

ALTER TABLE trailer_ctpat_info_history ADD CONSTRAINT fk_trailer_ctpat_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE trailer_ctpat_info_history ADD CONSTRAINT fk_trailer_ctpat_trailer FOREIGN KEY (trailer_id, tenant) REFERENCES trailers(id, tenant);
ALTER TABLE trailer_ctpat_info_history ADD CONSTRAINT fk_trailer_ctpat_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE trailer_ctpat_info_history ADD CONSTRAINT fk_trailer_ctpat_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

ALTER TABLE trailer_intermodal_origin_time_history ADD CONSTRAINT fk_trailer_intermodal_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE trailer_intermodal_origin_time_history ADD CONSTRAINT fk_trailer_intermodal_trailer FOREIGN KEY (trailer_id, tenant) REFERENCES trailers(id, tenant);
ALTER TABLE trailer_intermodal_origin_time_history ADD CONSTRAINT fk_trailer_intermodal_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE trailer_intermodal_origin_time_history ADD CONSTRAINT fk_trailer_intermodal_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

ALTER TABLE trailer_empty_pickup_history ADD CONSTRAINT fk_trailer_empty_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE trailer_empty_pickup_history ADD CONSTRAINT fk_trailer_empty_trailer FOREIGN KEY (trailer_id, tenant) REFERENCES trailers(id, tenant);
ALTER TABLE trailer_empty_pickup_history ADD CONSTRAINT fk_trailer_empty_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE trailer_empty_pickup_history ADD CONSTRAINT fk_trailer_empty_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

ALTER TABLE trailer_preffered_location_history ADD CONSTRAINT fk_trailer_pref_loc_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE trailer_preffered_location_history ADD CONSTRAINT fk_trailer_pref_loc_trailer FOREIGN KEY (trailer_id, tenant) REFERENCES trailers(id, tenant);
ALTER TABLE trailer_preffered_location_history ADD CONSTRAINT fk_trailer_pref_loc_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE trailer_preffered_location_history ADD CONSTRAINT fk_trailer_pref_loc_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- ================================
-- LOCATION CONSTRAINTS
-- ================================

-- Location Groups
ALTER TABLE location_groups ADD CONSTRAINT fk_location_groups_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE location_groups ADD CONSTRAINT fk_location_groups_geofence FOREIGN KEY (geofence_master_id, tenant) REFERENCES geofence_master(id, tenant);
ALTER TABLE location_groups ADD CONSTRAINT fk_location_groups_zone FOREIGN KEY (zone_id, tenant) REFERENCES zones_master(id, tenant);
ALTER TABLE location_groups ADD CONSTRAINT fk_location_groups_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE location_groups ADD CONSTRAINT fk_location_groups_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Locations
ALTER TABLE locations ADD CONSTRAINT fk_locations_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE locations ADD CONSTRAINT fk_locations_group FOREIGN KEY (location_group_id, tenant) REFERENCES location_groups(id, tenant);
ALTER TABLE locations ADD CONSTRAINT fk_locations_geofence FOREIGN KEY (geofence_master_id, tenant) REFERENCES geofence_master(id, tenant);
ALTER TABLE locations ADD CONSTRAINT fk_locations_zone FOREIGN KEY (zone_id, tenant) REFERENCES zones_master(id, tenant);
ALTER TABLE locations ADD CONSTRAINT fk_locations_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE locations ADD CONSTRAINT fk_locations_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Location Trailer History
ALTER TABLE location_trailer_history ADD CONSTRAINT fk_loc_trailer_hist_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE location_trailer_history ADD CONSTRAINT fk_loc_trailer_hist_trailer FOREIGN KEY (trailer_id, tenant) REFERENCES trailers(id, tenant);
ALTER TABLE location_trailer_history ADD CONSTRAINT fk_loc_trailer_hist_location FOREIGN KEY (location_id, tenant) REFERENCES locations(id, tenant);
ALTER TABLE location_trailer_history ADD CONSTRAINT fk_loc_trailer_hist_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE location_trailer_history ADD CONSTRAINT fk_loc_trailer_hist_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Unpainted Lot Trailer Info
ALTER TABLE unpainted_lot_trailer_info ADD CONSTRAINT fk_unpainted_lot_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE unpainted_lot_trailer_info ADD CONSTRAINT fk_unpainted_lot_location FOREIGN KEY (location_id, tenant) REFERENCES locations(id, tenant);
ALTER TABLE unpainted_lot_trailer_info ADD CONSTRAINT fk_unpainted_lot_trailer FOREIGN KEY (trailer_id, tenant) REFERENCES trailers(id, tenant);
ALTER TABLE unpainted_lot_trailer_info ADD CONSTRAINT fk_unpainted_lot_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE unpainted_lot_trailer_info ADD CONSTRAINT fk_unpainted_lot_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Location Queue
ALTER TABLE location_queue ADD CONSTRAINT fk_location_queue_location FOREIGN KEY (location_id, tenant) REFERENCES locations(id, tenant);
ALTER TABLE location_queue ADD CONSTRAINT fk_location_queue_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE location_queue ADD CONSTRAINT fk_location_queue_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Location Queue History
ALTER TABLE location_queue_history ADD CONSTRAINT fk_loc_queue_hist_location FOREIGN KEY (location_id, tenant) REFERENCES locations(id, tenant);
ALTER TABLE location_queue_history ADD CONSTRAINT fk_loc_queue_hist_trailer FOREIGN KEY (trailer_id, tenant) REFERENCES trailers(id, tenant);
ALTER TABLE location_queue_history ADD CONSTRAINT fk_loc_queue_hist_user FOREIGN KEY (user_id, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE location_queue_history ADD CONSTRAINT fk_loc_queue_hist_task FOREIGN KEY (task_id, tenant) REFERENCES tasks(id, tenant);
ALTER TABLE location_queue_history ADD CONSTRAINT fk_loc_queue_hist_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE location_queue_history ADD CONSTRAINT fk_loc_queue_hist_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- ================================
-- TASK CONSTRAINTS
-- ================================

-- Tasks
ALTER TABLE tasks ADD CONSTRAINT fk_tasks_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE tasks ADD CONSTRAINT fk_tasks_requestor FOREIGN KEY (requestor_id, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE tasks ADD CONSTRAINT fk_tasks_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE tasks ADD CONSTRAINT fk_tasks_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Task Status History
ALTER TABLE tasks_status_history ADD CONSTRAINT fk_task_status_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE tasks_status_history ADD CONSTRAINT fk_task_status_task FOREIGN KEY (task_id, tenant) REFERENCES tasks(id, tenant);
ALTER TABLE tasks_status_history ADD CONSTRAINT fk_task_status_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE tasks_status_history ADD CONSTRAINT fk_task_status_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Task Trailer History
ALTER TABLE tasks_trailer_history ADD CONSTRAINT fk_task_trailer_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE tasks_trailer_history ADD CONSTRAINT fk_task_trailer_task FOREIGN KEY (task_id, tenant) REFERENCES tasks(id, tenant);
ALTER TABLE tasks_trailer_history ADD CONSTRAINT fk_task_trailer_trailer FOREIGN KEY (trailer_id, tenant) REFERENCES trailers(id, tenant);
ALTER TABLE tasks_trailer_history ADD CONSTRAINT fk_task_trailer_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE tasks_trailer_history ADD CONSTRAINT fk_task_trailer_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Task Priority History
ALTER TABLE tasks_priority_history ADD CONSTRAINT fk_task_priority_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE tasks_priority_history ADD CONSTRAINT fk_task_priority_task FOREIGN KEY (task_id, tenant) REFERENCES tasks(id, tenant);
ALTER TABLE tasks_priority_history ADD CONSTRAINT fk_task_priority_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE tasks_priority_history ADD CONSTRAINT fk_task_priority_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Task Assignment History
ALTER TABLE tasks_assignment_history ADD CONSTRAINT fk_task_assign_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE tasks_assignment_history ADD CONSTRAINT fk_task_assign_task FOREIGN KEY (task_id, tenant) REFERENCES tasks(id, tenant);
ALTER TABLE tasks_assignment_history ADD CONSTRAINT fk_task_assign_assignee FOREIGN KEY (assignee_id, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE tasks_assignment_history ADD CONSTRAINT fk_task_assign_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE tasks_assignment_history ADD CONSTRAINT fk_task_assign_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Move Tasks Details History
ALTER TABLE move_tasks_details_history ADD CONSTRAINT fk_move_task_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE move_tasks_details_history ADD CONSTRAINT fk_move_task_task FOREIGN KEY (task_id, tenant) REFERENCES tasks(id, tenant);
ALTER TABLE move_tasks_details_history ADD CONSTRAINT fk_move_task_to_location FOREIGN KEY (to_location_id, tenant) REFERENCES locations(id, tenant);
ALTER TABLE move_tasks_details_history ADD CONSTRAINT fk_move_task_from_location FOREIGN KEY (from_location_id, tenant) REFERENCES locations(id, tenant);
ALTER TABLE move_tasks_details_history ADD CONSTRAINT fk_move_task_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE move_tasks_details_history ADD CONSTRAINT fk_move_task_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Precool Tasks Details History
ALTER TABLE precool_tasks_details_history ADD CONSTRAINT fk_precool_task_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE precool_tasks_details_history ADD CONSTRAINT fk_precool_task_task FOREIGN KEY (task_id, tenant) REFERENCES tasks(id, tenant);
ALTER TABLE precool_tasks_details_history ADD CONSTRAINT fk_precool_task_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE precool_tasks_details_history ADD CONSTRAINT fk_precool_task_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Refuel Tasks Details History
ALTER TABLE refuel_tasks_details_history ADD CONSTRAINT fk_refuel_task_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE refuel_tasks_details_history ADD CONSTRAINT fk_refuel_task_task FOREIGN KEY (task_id, tenant) REFERENCES tasks(id, tenant);
ALTER TABLE refuel_tasks_details_history ADD CONSTRAINT fk_refuel_task_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE refuel_tasks_details_history ADD CONSTRAINT fk_refuel_task_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Task Assignee Comments History
ALTER TABLE tasks_assignee_comments_history ADD CONSTRAINT fk_task_assignee_comm_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE tasks_assignee_comments_history ADD CONSTRAINT fk_task_assignee_comm_task FOREIGN KEY (task_id, tenant) REFERENCES tasks(id, tenant);
ALTER TABLE tasks_assignee_comments_history ADD CONSTRAINT fk_task_assignee_comm_assignee FOREIGN KEY (assignee_id, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE tasks_assignee_comments_history ADD CONSTRAINT fk_task_assignee_comm_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE tasks_assignee_comments_history ADD CONSTRAINT fk_task_assignee_comm_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Task Requestor Comments History
ALTER TABLE tasks_requestor_comments_history ADD CONSTRAINT fk_task_req_comm_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE tasks_requestor_comments_history ADD CONSTRAINT fk_task_req_comm_task FOREIGN KEY (task_id, tenant) REFERENCES tasks(id, tenant);
ALTER TABLE tasks_requestor_comments_history ADD CONSTRAINT fk_task_req_comm_requestor FOREIGN KEY (requestor_id, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE tasks_requestor_comments_history ADD CONSTRAINT fk_task_req_comm_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE tasks_requestor_comments_history ADD CONSTRAINT fk_task_req_comm_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Task Notes History
ALTER TABLE tasks_notes_history ADD CONSTRAINT fk_task_notes_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE tasks_notes_history ADD CONSTRAINT fk_task_notes_task FOREIGN KEY (task_id, tenant) REFERENCES tasks(id, tenant);
ALTER TABLE tasks_notes_history ADD CONSTRAINT fk_task_notes_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE tasks_notes_history ADD CONSTRAINT fk_task_notes_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- ================================
-- SHIPMENT CONSTRAINTS
-- ================================

-- Shipments
ALTER TABLE shipments ADD CONSTRAINT fk_shipments_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE shipments ADD CONSTRAINT fk_shipments_origin_facility FOREIGN KEY (origin_facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE shipments ADD CONSTRAINT fk_shipments_dest_facility FOREIGN KEY (destination_facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE shipments ADD CONSTRAINT fk_shipments_carrier FOREIGN KEY (carrier_master_id, tenant) REFERENCES carrier_master(id, tenant);
ALTER TABLE shipments ADD CONSTRAINT fk_shipments_trailer FOREIGN KEY (trailer_id, tenant) REFERENCES trailers(id, tenant);
ALTER TABLE shipments ADD CONSTRAINT fk_shipments_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE shipments ADD CONSTRAINT fk_shipments_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Shipment History Tables
ALTER TABLE shipment_last_associated_trailer_history ADD CONSTRAINT fk_ship_last_trailer_shipment FOREIGN KEY (shipment_id, tenant) REFERENCES shipments(id, tenant);
ALTER TABLE shipment_last_associated_trailer_history ADD CONSTRAINT fk_ship_last_trailer_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE shipment_last_associated_trailer_history ADD CONSTRAINT fk_ship_last_trailer_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE shipment_last_associated_trailer_history ADD CONSTRAINT fk_ship_last_trailer_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

ALTER TABLE shipment_details_history ADD CONSTRAINT fk_ship_details_shipment FOREIGN KEY (shipment_id, tenant) REFERENCES shipments(id, tenant);
ALTER TABLE shipment_details_history ADD CONSTRAINT fk_ship_details_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE shipment_details_history ADD CONSTRAINT fk_ship_details_customer FOREIGN KEY (customer_id, tenant) REFERENCES customers_master(id, tenant);
ALTER TABLE shipment_details_history ADD CONSTRAINT fk_ship_details_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE shipment_details_history ADD CONSTRAINT fk_ship_details_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

ALTER TABLE shipment_canceled_history ADD CONSTRAINT fk_ship_canceled_shipment FOREIGN KEY (shipment_id, tenant) REFERENCES shipments(id, tenant);
ALTER TABLE shipment_canceled_history ADD CONSTRAINT fk_ship_canceled_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE shipment_canceled_history ADD CONSTRAINT fk_ship_canceled_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE shipment_canceled_history ADD CONSTRAINT fk_ship_canceled_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

ALTER TABLE shipment_scheduled_details_history ADD CONSTRAINT fk_ship_sched_shipment FOREIGN KEY (shipment_id, tenant) REFERENCES shipments(id, tenant);
ALTER TABLE shipment_scheduled_details_history ADD CONSTRAINT fk_ship_sched_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE shipment_scheduled_details_history ADD CONSTRAINT fk_ship_sched_carrier FOREIGN KEY (scheduled_carrier_id, tenant) REFERENCES carrier_master(id, tenant);
ALTER TABLE shipment_scheduled_details_history ADD CONSTRAINT fk_ship_sched_trailer_type FOREIGN KEY (scheduled_trailer_type_id, tenant) REFERENCES trailer_types_master(id, tenant);
ALTER TABLE shipment_scheduled_details_history ADD CONSTRAINT fk_ship_sched_broker FOREIGN KEY (expected_broker_id, tenant) REFERENCES carrier_master(id, tenant);
ALTER TABLE shipment_scheduled_details_history ADD CONSTRAINT fk_ship_sched_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE shipment_scheduled_details_history ADD CONSTRAINT fk_ship_sched_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

ALTER TABLE shipment_refernce_number_history ADD CONSTRAINT fk_ship_ref_shipment FOREIGN KEY (shipment_id, tenant) REFERENCES shipments(id, tenant);
ALTER TABLE shipment_refernce_number_history ADD CONSTRAINT fk_ship_ref_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE shipment_refernce_number_history ADD CONSTRAINT fk_ship_ref_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE shipment_refernce_number_history ADD CONSTRAINT fk_ship_ref_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

ALTER TABLE scheduled_appointment_time_history ADD CONSTRAINT fk_sched_appt_shipment FOREIGN KEY (shipment_id, tenant) REFERENCES shipments(id, tenant);
ALTER TABLE scheduled_appointment_time_history ADD CONSTRAINT fk_sched_appt_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE scheduled_appointment_time_history ADD CONSTRAINT fk_sched_appt_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE scheduled_appointment_time_history ADD CONSTRAINT fk_sched_appt_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

ALTER TABLE shipment_estimated_arrival_time_history ADD CONSTRAINT fk_ship_eta_shipment FOREIGN KEY (shipment_id, tenant) REFERENCES shipments(id, tenant);
ALTER TABLE shipment_estimated_arrival_time_history ADD CONSTRAINT fk_ship_eta_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE shipment_estimated_arrival_time_history ADD CONSTRAINT fk_ship_eta_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE shipment_estimated_arrival_time_history ADD CONSTRAINT fk_ship_eta_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

ALTER TABLE shipment_processed_history ADD CONSTRAINT fk_ship_proc_shipment FOREIGN KEY (shipment_id, tenant) REFERENCES shipments(id, tenant);
ALTER TABLE shipment_processed_history ADD CONSTRAINT fk_ship_proc_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE shipment_processed_history ADD CONSTRAINT fk_ship_proc_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE shipment_processed_history ADD CONSTRAINT fk_ship_proc_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

ALTER TABLE shipment_priority_history ADD CONSTRAINT fk_ship_priority_shipment FOREIGN KEY (shipment_id, tenant) REFERENCES shipments(id, tenant);
ALTER TABLE shipment_priority_history ADD CONSTRAINT fk_ship_priority_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE shipment_priority_history ADD CONSTRAINT fk_ship_priority_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE shipment_priority_history ADD CONSTRAINT fk_ship_priority_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- ================================
-- DETENTION RATES HISTORY
-- ================================

ALTER TABLE detention_rates_history ADD CONSTRAINT fk_detention_hist_rate FOREIGN KEY (detention_rate_id, tenant) REFERENCES detention_rates_master(id, tenant);
ALTER TABLE detention_rates_history ADD CONSTRAINT fk_detention_hist_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE detention_rates_history ADD CONSTRAINT fk_detention_hist_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- ================================
-- OTHER OPERATIONAL CONSTRAINTS
-- ================================

-- Carrier Sites
ALTER TABLE carrier_sites ADD CONSTRAINT fk_carrier_sites_carrier FOREIGN KEY (carrier_master_id, tenant) REFERENCES carrier_master(id, tenant);
ALTER TABLE carrier_sites ADD CONSTRAINT fk_carrier_sites_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE carrier_sites ADD CONSTRAINT fk_carrier_sites_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE carrier_sites ADD CONSTRAINT fk_carrier_sites_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Tractors
ALTER TABLE tractors ADD CONSTRAINT fk_tractors_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE tractors ADD CONSTRAINT fk_tractors_carrier FOREIGN KEY (carrier_master_id, tenant) REFERENCES carrier_master(id, tenant);
ALTER TABLE tractors ADD CONSTRAINT fk_tractors_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE tractors ADD CONSTRAINT fk_tractors_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Drivers
ALTER TABLE drivers ADD CONSTRAINT fk_drivers_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE drivers ADD CONSTRAINT fk_drivers_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Gate Operations
ALTER TABLE gate_operations ADD CONSTRAINT fk_gate_ops_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE gate_operations ADD CONSTRAINT fk_gate_ops_trailer FOREIGN KEY (trailer_id, tenant) REFERENCES trailers(id, tenant);
ALTER TABLE gate_operations ADD CONSTRAINT fk_gate_ops_driver FOREIGN KEY (driver_id, tenant) REFERENCES drivers(id, tenant);
ALTER TABLE gate_operations ADD CONSTRAINT fk_gate_ops_tractor FOREIGN KEY (tractor_master_id, tenant) REFERENCES tractors(id, tenant);
ALTER TABLE gate_operations ADD CONSTRAINT fk_gate_ops_guard FOREIGN KEY (guard_id, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE gate_operations ADD CONSTRAINT fk_gate_ops_location FOREIGN KEY (location_id, tenant) REFERENCES locations(id, tenant);
ALTER TABLE gate_operations ADD CONSTRAINT fk_gate_ops_appointment FOREIGN KEY (appointment_id, tenant) REFERENCES appointments(id, tenant);
ALTER TABLE gate_operations ADD CONSTRAINT fk_gate_ops_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE gate_operations ADD CONSTRAINT fk_gate_ops_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Appointments
ALTER TABLE appointments ADD CONSTRAINT fk_appointments_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE appointments ADD CONSTRAINT fk_appointments_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE appointments ADD CONSTRAINT fk_appointments_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Appointment History
ALTER TABLE appointment_history ADD CONSTRAINT fk_appt_hist_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE appointment_history ADD CONSTRAINT fk_appt_hist_appointment FOREIGN KEY (appointment_id, tenant) REFERENCES appointments(id, tenant);
ALTER TABLE appointment_history ADD CONSTRAINT fk_appt_hist_inbound_trailer FOREIGN KEY (inbound_trailer_id, tenant) REFERENCES trailers(id, tenant);
ALTER TABLE appointment_history ADD CONSTRAINT fk_appt_hist_outbound_trailer FOREIGN KEY (outbound_trailer_id, tenant) REFERENCES trailers(id, tenant);
ALTER TABLE appointment_history ADD CONSTRAINT fk_appt_hist_tractor FOREIGN KEY (tractor_id, tenant) REFERENCES tractors(id, tenant);
ALTER TABLE appointment_history ADD CONSTRAINT fk_appt_hist_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE appointment_history ADD CONSTRAINT fk_appt_hist_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- ================================
-- SPOTTER MANAGEMENT CONSTRAINTS
-- ================================

-- Spotter Vehicles Master
ALTER TABLE spotter_vehicles_master ADD CONSTRAINT fk_spotter_veh_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE spotter_vehicles_master ADD CONSTRAINT fk_spotter_veh_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE spotter_vehicles_master ADD CONSTRAINT fk_spotter_veh_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Spotter Location History
ALTER TABLE spotter_location_history ADD CONSTRAINT fk_spotter_loc_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE spotter_location_history ADD CONSTRAINT fk_spotter_loc_vehicle FOREIGN KEY (spotter_vehicle_id, tenant) REFERENCES spotter_vehicles_master(id, tenant);
ALTER TABLE spotter_location_history ADD CONSTRAINT fk_spotter_loc_spotter FOREIGN KEY (spotter_id, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE spotter_location_history ADD CONSTRAINT fk_spotter_loc_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE spotter_location_history ADD CONSTRAINT fk_spotter_loc_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Spotter Task History
ALTER TABLE spotter_task_history ADD CONSTRAINT fk_spotter_task_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE spotter_task_history ADD CONSTRAINT fk_spotter_task_spotter FOREIGN KEY (spotter_id, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE spotter_task_history ADD CONSTRAINT fk_spotter_task_vehicle FOREIGN KEY (spotter_vehicle_id, tenant) REFERENCES spotter_vehicles_master(id, tenant);
ALTER TABLE spotter_task_history ADD CONSTRAINT fk_spotter_task_task FOREIGN KEY (task_id, tenant) REFERENCES tasks(id, tenant);
ALTER TABLE spotter_task_history ADD CONSTRAINT fk_spotter_task_trailer FOREIGN KEY (trailer_id, tenant) REFERENCES trailers(id, tenant);
ALTER TABLE spotter_task_history ADD CONSTRAINT fk_spotter_task_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE spotter_task_history ADD CONSTRAINT fk_spotter_task_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Spotter Vehicle Location History (duplicate table)
ALTER TABLE spotter_vehicle_location_history ADD CONSTRAINT fk_spotter_veh_loc_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE spotter_vehicle_location_history ADD CONSTRAINT fk_spotter_veh_loc_vehicle FOREIGN KEY (spotter_vehicle_id, tenant) REFERENCES spotter_vehicles_master(id, tenant);
ALTER TABLE spotter_vehicle_location_history ADD CONSTRAINT fk_spotter_veh_loc_spotter FOREIGN KEY (spotter_id, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE spotter_vehicle_location_history ADD CONSTRAINT fk_spotter_veh_loc_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE spotter_vehicle_location_history ADD CONSTRAINT fk_spotter_veh_loc_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Spotter Vehicle Task History (duplicate table)
ALTER TABLE spotter_vehicle_task_history ADD CONSTRAINT fk_spotter_veh_task_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE spotter_vehicle_task_history ADD CONSTRAINT fk_spotter_veh_task_spotter FOREIGN KEY (spotter_id, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE spotter_vehicle_task_history ADD CONSTRAINT fk_spotter_veh_task_vehicle FOREIGN KEY (spotter_vehicle_id, tenant) REFERENCES spotter_vehicles_master(id, tenant);
ALTER TABLE spotter_vehicle_task_history ADD CONSTRAINT fk_spotter_veh_task_task FOREIGN KEY (task_id, tenant) REFERENCES tasks(id, tenant);
ALTER TABLE spotter_vehicle_task_history ADD CONSTRAINT fk_spotter_veh_task_trailer FOREIGN KEY (trailer_id, tenant) REFERENCES trailers(id, tenant);
ALTER TABLE spotter_vehicle_task_history ADD CONSTRAINT fk_spotter_veh_task_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE spotter_vehicle_task_history ADD CONSTRAINT fk_spotter_veh_task_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Spotter Teams Master
ALTER TABLE spotter_teams_master ADD CONSTRAINT fk_spotter_teams_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE spotter_teams_master ADD CONSTRAINT fk_spotter_teams_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE spotter_teams_master ADD CONSTRAINT fk_spotter_teams_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Spotter Teams Vehicles
ALTER TABLE spotter_teams_vehicles ADD CONSTRAINT fk_spotter_teams_veh_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE spotter_teams_vehicles ADD CONSTRAINT fk_spotter_teams_veh_team FOREIGN KEY (switcher_team_id, tenant) REFERENCES spotter_teams_master(id, tenant);
ALTER TABLE spotter_teams_vehicles ADD CONSTRAINT fk_spotter_teams_veh_vehicle FOREIGN KEY (spotter_vehicle_id, tenant) REFERENCES spotter_vehicles_master(id, tenant);
ALTER TABLE spotter_teams_vehicles ADD CONSTRAINT fk_spotter_teams_veh_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE spotter_teams_vehicles ADD CONSTRAINT fk_spotter_teams_veh_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Spotter Team Members
ALTER TABLE spotter_team_members ADD CONSTRAINT fk_spotter_team_mem_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE spotter_team_members ADD CONSTRAINT fk_spotter_team_mem_team FOREIGN KEY (switcher_team_id, tenant) REFERENCES spotter_teams_master(id, tenant);
ALTER TABLE spotter_team_members ADD CONSTRAINT fk_spotter_team_mem_spotter FOREIGN KEY (spotter_id, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE spotter_team_members ADD CONSTRAINT fk_spotter_team_mem_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE spotter_team_members ADD CONSTRAINT fk_spotter_team_mem_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Spotter Queue
ALTER TABLE spotter_queue ADD CONSTRAINT fk_spotter_queue_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE spotter_queue ADD CONSTRAINT fk_spotter_queue_spotter FOREIGN KEY (spotter_id, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE spotter_queue ADD CONSTRAINT fk_spotter_queue_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE spotter_queue ADD CONSTRAINT fk_spotter_queue_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Spotter Queue History
ALTER TABLE spotter_queue_history ADD CONSTRAINT fk_spotter_queue_hist_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE spotter_queue_history ADD CONSTRAINT fk_spotter_queue_hist_spotter FOREIGN KEY (spotter_id, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE spotter_queue_history ADD CONSTRAINT fk_spotter_queue_hist_task FOREIGN KEY (task_id, tenant) REFERENCES tasks(id, tenant);
ALTER TABLE spotter_queue_history ADD CONSTRAINT fk_spotter_queue_hist_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE spotter_queue_history ADD CONSTRAINT fk_spotter_queue_hist_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- ================================
-- FREIGHT MANAGEMENT CONSTRAINTS
-- ================================

-- Freights Master
ALTER TABLE freights_master ADD CONSTRAINT fk_freights_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE freights_master ADD CONSTRAINT fk_freights_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Freight Sites
ALTER TABLE freight_sites ADD CONSTRAINT fk_freight_sites_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE freight_sites ADD CONSTRAINT fk_freight_sites_freight FOREIGN KEY (freight_master_id, tenant) REFERENCES freights_master(id, tenant);
ALTER TABLE freight_sites ADD CONSTRAINT fk_freight_sites_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE freight_sites ADD CONSTRAINT fk_freight_sites_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Item Bundle
ALTER TABLE item_bundle ADD CONSTRAINT fk_item_bundle_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE item_bundle ADD CONSTRAINT fk_item_bundle_shipment FOREIGN KEY (shipment_id, tenant) REFERENCES shipments(id, tenant);
ALTER TABLE item_bundle ADD CONSTRAINT fk_item_bundle_freight FOREIGN KEY (freight_master_id, tenant) REFERENCES freights_master(id, tenant);
ALTER TABLE item_bundle ADD CONSTRAINT fk_item_bundle_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE item_bundle ADD CONSTRAINT fk_item_bundle_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- ================================
-- SITE SETTINGS CONSTRAINTS
-- ================================

-- Site Settings Master
ALTER TABLE site_settings_master ADD CONSTRAINT fk_site_settings_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE site_settings_master ADD CONSTRAINT fk_site_settings_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE site_settings_master ADD CONSTRAINT fk_site_settings_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Site Settings History
ALTER TABLE site_settings_history ADD CONSTRAINT fk_site_settings_hist_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE site_settings_history ADD CONSTRAINT fk_site_settings_hist_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE site_settings_history ADD CONSTRAINT fk_site_settings_hist_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Product Protection Site Settings History
ALTER TABLE product_protection_site_settings_history ADD CONSTRAINT fk_pp_site_settings_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE product_protection_site_settings_history ADD CONSTRAINT fk_pp_site_settings_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE product_protection_site_settings_history ADD CONSTRAINT fk_pp_site_settings_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- ================================
-- RULES ENGINE CONSTRAINTS
-- ================================

-- Location Assignment Rules Master
ALTER TABLE location_assignment_rules_master ADD CONSTRAINT fk_loc_assign_rules_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE location_assignment_rules_master ADD CONSTRAINT fk_loc_assign_rules_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE location_assignment_rules_master ADD CONSTRAINT fk_loc_assign_rules_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Automatic Move Request Creation Rules Master
ALTER TABLE automatic_move_request_creation_rules_master ADD CONSTRAINT fk_auto_move_rules_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE automatic_move_request_creation_rules_master ADD CONSTRAINT fk_auto_move_rules_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE automatic_move_request_creation_rules_master ADD CONSTRAINT fk_auto_move_rules_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Task Restriction Rules Master
ALTER TABLE task_restriction_rules_master ADD CONSTRAINT fk_task_restrict_rules_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE task_restriction_rules_master ADD CONSTRAINT fk_task_restrict_rules_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE task_restriction_rules_master ADD CONSTRAINT fk_task_restrict_rules_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- ================================
-- REPORTING ENTITIES CONSTRAINTS
-- ================================

-- Buildings Master
ALTER TABLE buildings_master ADD CONSTRAINT fk_buildings_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE buildings_master ADD CONSTRAINT fk_buildings_geofence FOREIGN KEY (geofence_master_id, tenant) REFERENCES geofence_master(id, tenant);
ALTER TABLE buildings_master ADD CONSTRAINT fk_buildings_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE buildings_master ADD CONSTRAINT fk_buildings_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Reports Master
ALTER TABLE reports_master ADD CONSTRAINT fk_reports_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE reports_master ADD CONSTRAINT fk_reports_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE reports_master ADD CONSTRAINT fk_reports_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Reports Sites
ALTER TABLE reports_sites ADD CONSTRAINT fk_reports_sites_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE reports_sites ADD CONSTRAINT fk_reports_sites_report FOREIGN KEY (reports_master_id, tenant) REFERENCES reports_master(id, tenant);
ALTER TABLE reports_sites ADD CONSTRAINT fk_reports_sites_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE reports_sites ADD CONSTRAINT fk_reports_sites_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Scheduled Report Emails Master
ALTER TABLE scheduled_report_emails_master ADD CONSTRAINT fk_sched_report_emails_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE scheduled_report_emails_master ADD CONSTRAINT fk_sched_report_emails_report FOREIGN KEY (reports_master_id, tenant) REFERENCES reports_master(id, tenant);
ALTER TABLE scheduled_report_emails_master ADD CONSTRAINT fk_sched_report_emails_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE scheduled_report_emails_master ADD CONSTRAINT fk_sched_report_emails_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- ================================
-- RFID AND OTHER ENTITIES CONSTRAINTS
-- ================================

-- RFID Tag Reads History
ALTER TABLE rfid_tag_reads_history ADD CONSTRAINT fk_rfid_reads_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE rfid_tag_reads_history ADD CONSTRAINT fk_rfid_reads_trailer FOREIGN KEY (trailer_id, tenant) REFERENCES trailers(id, tenant);
ALTER TABLE rfid_tag_reads_history ADD CONSTRAINT fk_rfid_reads_location FOREIGN KEY (closest_location_id, tenant) REFERENCES locations(id, tenant);
ALTER TABLE rfid_tag_reads_history ADD CONSTRAINT fk_rfid_reads_tag_type FOREIGN KEY (tag_type_id, tenant) REFERENCES tag_types_master(id, tenant);
ALTER TABLE rfid_tag_reads_history ADD CONSTRAINT fk_rfid_reads_spotter_vehicle FOREIGN KEY (spotter_vehicle_id, tenant) REFERENCES spotter_vehicles_master(id, tenant);
ALTER TABLE rfid_tag_reads_history ADD CONSTRAINT fk_rfid_reads_spotter FOREIGN KEY (spotter_id, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE rfid_tag_reads_history ADD CONSTRAINT fk_rfid_reads_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE rfid_tag_reads_history ADD CONSTRAINT fk_rfid_reads_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- RFID Tag Reads History - References to Trailer History Tables
-- Note: These create complex dependencies and may need to be handled at application level
-- ALTER TABLE rfid_tag_reads_history ADD CONSTRAINT fk_rfid_reads_trailer_loc_hist FOREIGN KEY (trailer_location_history_id, tenant) REFERENCES trailer_location_history(id, tenant);
-- ALTER TABLE rfid_tag_reads_history ADD CONSTRAINT fk_rfid_reads_trailer_state_hist FOREIGN KEY (trailer_state_history_id, tenant) REFERENCES trailer_state_history(id, tenant);
-- ... (other history table references would follow similar pattern)

-- CTPAT Settings Master
ALTER TABLE ctpat_settings_master ADD CONSTRAINT fk_ctpat_settings_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE ctpat_settings_master ADD CONSTRAINT fk_ctpat_settings_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Trailer Pool Settings Master
ALTER TABLE trailer_pool_settings_master ADD CONSTRAINT fk_trailer_pool_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE trailer_pool_settings_master ADD CONSTRAINT fk_trailer_pool_carrier FOREIGN KEY (carrier_master_id, tenant) REFERENCES carrier_master(id, tenant);
ALTER TABLE trailer_pool_settings_master ADD CONSTRAINT fk_trailer_pool_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE trailer_pool_settings_master ADD CONSTRAINT fk_trailer_pool_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Webhooks Config Master
ALTER TABLE webhooks_config_master ADD CONSTRAINT fk_webhooks_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE webhooks_config_master ADD CONSTRAINT fk_webhooks_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Trailer Tags Master
ALTER TABLE trailer_tags_master ADD CONSTRAINT fk_trailer_tags_carrier FOREIGN KEY (carrier_master_id, tenant) REFERENCES carrier_master(id, tenant);
ALTER TABLE trailer_tags_master ADD CONSTRAINT fk_trailer_tags_trailer_type FOREIGN KEY (trailer_type_master_id, tenant) REFERENCES trailer_types_master(id, tenant);
ALTER TABLE trailer_tags_master ADD CONSTRAINT fk_trailer_tags_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE trailer_tags_master ADD CONSTRAINT fk_trailer_tags_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Trailer Tags Sites
ALTER TABLE trailer_tags_sites ADD CONSTRAINT fk_trailer_tags_sites_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE trailer_tags_sites ADD CONSTRAINT fk_trailer_tags_sites_tag FOREIGN KEY (trailer_tag_id, tenant) REFERENCES trailer_tags_master(id, tenant);
ALTER TABLE trailer_tags_sites ADD CONSTRAINT fk_trailer_tags_sites_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE trailer_tags_sites ADD CONSTRAINT fk_trailer_tags_sites_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- Carrier Eligibility
ALTER TABLE carrier_eligibility ADD CONSTRAINT fk_carrier_elig_facility FOREIGN KEY (facility_master_id, tenant) REFERENCES facility_master(id, tenant);
ALTER TABLE carrier_eligibility ADD CONSTRAINT fk_carrier_elig_tractor_carrier FOREIGN KEY (tractor_carrier_master_id, tenant) REFERENCES carrier_master(id, tenant);
ALTER TABLE carrier_eligibility ADD CONSTRAINT fk_carrier_elig_trailer_carrier FOREIGN KEY (trailer_carrier_master_id, tenant) REFERENCES carrier_master(id, tenant);
ALTER TABLE carrier_eligibility ADD CONSTRAINT fk_carrier_elig_created_by FOREIGN KEY (created_by, tenant) REFERENCES users_master(id, tenant);
ALTER TABLE carrier_eligibility ADD CONSTRAINT fk_carrier_elig_updated_by FOREIGN KEY (updated_by, tenant) REFERENCES users_master(id, tenant);

-- ================================
-- CIRCULAR DEPENDENCY HANDLING
-- ================================
-- These constraints involve circular dependencies and should be added after all tables are created
-- They may need to be added with DEFERRABLE INITIALLY DEFERRED option or handled at application level

-- Trailers references to current history records
ALTER TABLE trailers ADD CONSTRAINT fk_trailers_state_hist FOREIGN KEY (trailer_state_history_id, tenant) REFERENCES trailer_state_history(id, tenant) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE trailers ADD CONSTRAINT fk_trailers_location_hist FOREIGN KEY (trailer_location_history_id, tenant) REFERENCES trailer_location_history(id, tenant) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE trailers ADD CONSTRAINT fk_trailers_attributes_hist FOREIGN KEY (trailer_attributes_history_id, tenant) REFERENCES trailer_attributes_history(id, tenant) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE trailers ADD CONSTRAINT fk_trailers_rfid_hist FOREIGN KEY (trailer_rfid_detail_history_id, tenant) REFERENCES trailer_rfid_detail_history(id, tenant) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE trailers ADD CONSTRAINT fk_trailers_detention_hist FOREIGN KEY (trailer_detention_history_id, tenant) REFERENCES trailer_detention_history(id, tenant) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE trailers ADD CONSTRAINT fk_trailers_load_status_hist FOREIGN KEY (trailer_load_status_history_id, tenant) REFERENCES trailer_load_status_history(id, tenant) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE trailers ADD CONSTRAINT fk_trailers_seal_status_hist FOREIGN KEY (trailer_seal_status_history_id, tenant) REFERENCES trailer_seal_status_history(id, tenant) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE trailers ADD CONSTRAINT fk_trailers_process_status_hist FOREIGN KEY (trailer_process_status_history_id, tenant) REFERENCES trailer_process_status_history(id, tenant) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE trailers ADD CONSTRAINT fk_trailers_shipment_assoc_hist FOREIGN KEY (trailer_shipment_association_history_id, tenant) REFERENCES trailer_shipments_association_history(id, tenant) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE trailers ADD CONSTRAINT fk_trailers_exp_ob_ship_hist FOREIGN KEY (trailer_expected_ob_shipments_association_history_id, tenant) REFERENCES trailer_expected_ob_shipments_association_history(id, tenant) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE trailers ADD CONSTRAINT fk_trailers_pp_ref_hist FOREIGN KEY (trailer_prodcut_protection_referigeration_check_history_id, tenant) REFERENCES trailer_prodcut_protection_referigeration_check_history(id, tenant) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE trailers ADD CONSTRAINT fk_trailers_pp_fuel_hist FOREIGN KEY (trailer_prodcut_protection_fuel_level_check_history_id, tenant) REFERENCES trailer_prodcut_protection_fuel_level_check_history(id, tenant) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE trailers ADD CONSTRAINT fk_trailers_pp_mode_hist FOREIGN KEY (trailer_prodcut_protection_mode_of_operation_check_history_id, tenant) REFERENCES trailer_prodcut_protection_mode_of_operation_check_history(id, tenant) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE trailers ADD CONSTRAINT fk_trailers_comments_hist FOREIGN KEY (trailer_comments_history_id, tenant) REFERENCES trailer_comments_history(id, tenant) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE trailers ADD CONSTRAINT fk_trailers_reserved_hist FOREIGN KEY (trailer_reserved_for_driver_pickup_history_id, tenant) REFERENCES trailer_reserved_for_driver_pickup_history(id, tenant) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE trailers ADD CONSTRAINT fk_trailers_inventory_hist FOREIGN KEY (trailer_inventory_update_history_id, tenant) REFERENCES trailer_inventory_update_history(id, tenant) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE trailers ADD CONSTRAINT fk_trailers_ctpat_hist FOREIGN KEY (trailer_ctpat_info_history_id, tenant) REFERENCES trailer_ctpat_info_history(id, tenant) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE trailers ADD CONSTRAINT fk_trailers_intermodal_hist FOREIGN KEY (trailer_intermodal_origin_time_history_id, tenant) REFERENCES trailer_intermodal_origin_time_history(id, tenant) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE trailers ADD CONSTRAINT fk_trailers_empty_pickup_hist FOREIGN KEY (trailer_empty_pickup_history_id, tenant) REFERENCES trailer_empty_pickup_history(id, tenant) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE trailers ADD CONSTRAINT fk_trailers_pref_loc_hist FOREIGN KEY (trailer_preffered_location_history_id, tenant) REFERENCES trailer_preffered_location_history(id, tenant) DEFERRABLE INITIALLY DEFERRED;

-- Locations reference to current history
ALTER TABLE locations ADD CONSTRAINT fk_locations_trailer_hist FOREIGN KEY (location_trailer_history_id, tenant) REFERENCES location_trailer_history(id, tenant) DEFERRABLE INITIALLY DEFERRED;

-- Location Queue reference to current history
ALTER TABLE location_queue ADD CONSTRAINT fk_location_queue_hist FOREIGN KEY (location_queue_history_id, tenant) REFERENCES location_queue_history(id, tenant) DEFERRABLE INITIALLY DEFERRED;

-- Tasks references to current history records
ALTER TABLE tasks ADD CONSTRAINT fk_tasks_status_hist FOREIGN KEY (tasks_status_history_id, tenant) REFERENCES tasks_status_history(id, tenant) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE tasks ADD CONSTRAINT fk_tasks_trailer_hist FOREIGN KEY (tasks_trailer_history_id, tenant) REFERENCES tasks_trailer_history(id, tenant) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE tasks ADD CONSTRAINT fk_tasks_priority_hist FOREIGN KEY (task_priority_history_id, tenant) REFERENCES tasks_priority_history(id, tenant) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE tasks ADD CONSTRAINT fk_tasks_assignment_hist FOREIGN KEY (tasks_assignment_history_id, tenant) REFERENCES tasks_assignment_history(id, tenant) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE tasks ADD CONSTRAINT fk_tasks_move_details_hist FOREIGN KEY (move_tasks_details_history_id, tenant) REFERENCES move_tasks_details_history(id, tenant) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE tasks ADD CONSTRAINT fk_tasks_assignee_comm_hist FOREIGN KEY (tasks_assignee_comments_history_id, tenant) REFERENCES tasks_assignee_comments_history(id, tenant) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE tasks ADD CONSTRAINT fk_tasks_requestor_comm_hist FOREIGN KEY (tasks_requestor_comments_history_id, tenant) REFERENCES tasks_requestor_comments_history(id, tenant) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE tasks ADD CONSTRAINT fk_tasks_refuel_hist FOREIGN KEY (refuel_tasks_details_history_id, tenant) REFERENCES refuel_tasks_details_history(id, tenant) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE tasks ADD CONSTRAINT fk_tasks_precool_hist FOREIGN KEY (precool_tasks_details_history_id, tenant) REFERENCES precool_tasks_details_history(id, tenant) DEFERRABLE INITIALLY DEFERRED;

-- Shipments references to current history records
ALTER TABLE shipments ADD CONSTRAINT fk_shipments_processed_hist FOREIGN KEY (shipment_processed_history_id, tenant) REFERENCES shipment_processed_history(id, tenant) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE shipments ADD CONSTRAINT fk_shipments_ref_num_hist FOREIGN KEY (shipment_refernce_number_history, tenant) REFERENCES shipment_refernce_number_history(id, tenant) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE shipments ADD CONSTRAINT fk_shipments_sched_appt_hist FOREIGN KEY (scheduled_appointment_time_history_id, tenant) REFERENCES scheduled_appointment_time_history(id, tenant) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE shipments ADD CONSTRAINT fk_shipments_priority_hist FOREIGN KEY (shipment_priority_history_id, tenant) REFERENCES shipment_priority_history(id, tenant) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE shipments ADD CONSTRAINT fk_shipments_details_hist FOREIGN KEY (shipment_details_history_id, tenant) REFERENCES shipment_details_history(id, tenant) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE shipments ADD CONSTRAINT fk_shipments_eta_hist FOREIGN KEY (shipment_estimated_arrival_time_history_id, tenant) REFERENCES shipment_estimated_arrival_time_history(id, tenant) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE shipments ADD CONSTRAINT fk_shipments_last_trailer_hist FOREIGN KEY (shipment_last_associated_trailer_history_id, tenant) REFERENCES shipment_last_associated_trailer_history(id, tenant) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE shipments ADD CONSTRAINT fk_shipments_canceled_hist FOREIGN KEY (shipment_canceled_history_id, tenant) REFERENCES shipment_canceled_history(id, tenant) DEFERRABLE INITIALLY DEFERRED;

-- Appointments reference to current history
ALTER TABLE appointments ADD CONSTRAINT fk_appointments_hist FOREIGN KEY (appointment_history_id, tenant) REFERENCES appointment_history(id, tenant) DEFERRABLE INITIALLY DEFERRED;

-- Spotter Vehicles Master references to current history
ALTER TABLE spotter_vehicles_master ADD CONSTRAINT fk_spotter_veh_task_hist FOREIGN KEY (spotter_vehicle_task_history_id, tenant) REFERENCES spotter_vehicle_task_history(id, tenant) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE spotter_vehicles_master ADD CONSTRAINT fk_spotter_veh_location_hist FOREIGN KEY (spotter_vehicle_location_history_id, tenant) REFERENCES spotter_vehicle_location_history(id, tenant) DEFERRABLE INITIALLY DEFERRED;

-- Spotter Queue reference to current history
ALTER TABLE spotter_queue ADD CONSTRAINT fk_spotter_queue_hist FOREIGN KEY (spotter_queue_history_id, tenant) REFERENCES spotter_queue_history(id, tenant) DEFERRABLE INITIALLY DEFERRED;

-- Site Settings Master references to current history
ALTER TABLE site_settings_master ADD CONSTRAINT fk_site_settings_hist FOREIGN KEY (site_settings_history_id, tenant) REFERENCES site_settings_history(id, tenant) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE site_settings_master ADD CONSTRAINT fk_site_settings_pp_hist FOREIGN KEY (product_protection_site_settings_history_id, tenant) REFERENCES product_protection_site_settings_history(id, tenant) DEFERRABLE INITIALLY DEFERRED;

-- Gate Operations references to history tables
-- Note: These are snapshot references and don't create circular dependencies
ALTER TABLE gate_operations ADD CONSTRAINT fk_gate_ops_trailer_state_hist FOREIGN KEY (trailer_state_history_id, tenant) REFERENCES trailer_state_history(id, tenant);
ALTER TABLE gate_operations ADD CONSTRAINT fk_gate_ops_trailer_attr_hist FOREIGN KEY (trailer_attributes_history_id, tenant) REFERENCES trailer_attributes_history(id, tenant);
ALTER TABLE gate_operations ADD CONSTRAINT fk_gate_ops_trailer_rfid_hist FOREIGN KEY (trailer_rfid_detail_history_id, tenant) REFERENCES trailer_rfid_detail_history(id, tenant);
ALTER TABLE gate_operations ADD CONSTRAINT fk_gate_ops_trailer_detention_hist FOREIGN KEY (trailer_detention_history_id, tenant) REFERENCES trailer_detention_history(id, tenant);
ALTER TABLE gate_operations ADD CONSTRAINT fk_gate_ops_trailer_load_hist FOREIGN KEY (trailer_load_status_history_id, tenant) REFERENCES trailer_load_status_history(id, tenant);
ALTER TABLE gate_operations ADD CONSTRAINT fk_gate_ops_trailer_seal_hist FOREIGN KEY (trailer_seal_status_history_id, tenant) REFERENCES trailer_seal_status_history(id, tenant);
ALTER TABLE gate_operations ADD CONSTRAINT fk_gate_ops_trailer_process_hist FOREIGN KEY (trailer_process_status_history_id, tenant) REFERENCES trailer_process_status_history(id, tenant);
ALTER TABLE gate_operations ADD CONSTRAINT fk_gate_ops_trailer_ship_hist FOREIGN KEY (trailer_shipment_association_history_id, tenant) REFERENCES trailer_shipments_association_history(id, tenant);
ALTER TABLE gate_operations ADD CONSTRAINT fk_gate_ops_trailer_exp_ship_hist FOREIGN KEY (trailer_expected_ob_shipments_association_history_id, tenant) REFERENCES trailer_expected_ob_shipments_association_history(id, tenant);
ALTER TABLE gate_operations ADD CONSTRAINT fk_gate_ops_trailer_pp_ref_hist FOREIGN KEY (trailer_prodcut_protection_referigeration_check_history_id, tenant) REFERENCES trailer_prodcut_protection_referigeration_check_history(id, tenant);
ALTER TABLE gate_operations ADD CONSTRAINT fk_gate_ops_trailer_pp_fuel_hist FOREIGN KEY (trailer_prodcut_protection_fuel_level_check_history_id, tenant) REFERENCES trailer_prodcut_protection_fuel_level_check_history(id, tenant);
ALTER TABLE gate_operations ADD CONSTRAINT fk_gate_ops_trailer_pp_mode_hist FOREIGN KEY (trailer_prodcut_protection_mode_of_operation_check_history_id, tenant) REFERENCES trailer_prodcut_protection_mode_of_operation_check_history(id, tenant);
ALTER TABLE gate_operations ADD CONSTRAINT fk_gate_ops_trailer_comments_hist FOREIGN KEY (trailer_comments_history_id, tenant) REFERENCES trailer_comments_history(id, tenant);
ALTER TABLE gate_operations ADD CONSTRAINT fk_gate_ops_trailer_reserved_hist FOREIGN KEY (trailer_reserved_for_driver_pickup_history_id, tenant) REFERENCES trailer_reserved_for_driver_pickup_history(id, tenant);
ALTER TABLE gate_operations ADD CONSTRAINT fk_gate_ops_trailer_inventory_hist FOREIGN KEY (trailer_inventory_update_history_id, tenant) REFERENCES trailer_inventory_update_history(id, tenant);
ALTER TABLE gate_operations ADD CONSTRAINT fk_gate_ops_trailer_ctpat_hist FOREIGN KEY (trailer_ctpat_info_history_id, tenant) REFERENCES trailer_ctpat_info_history(id, tenant);
ALTER TABLE gate_operations ADD CONSTRAINT fk_gate_ops_trailer_intermodal_hist FOREIGN KEY (trailer_intermodal_origin_time_history_id, tenant) REFERENCES trailer_intermodal_origin_time_history(id, tenant);
ALTER TABLE gate_operations ADD CONSTRAINT fk_gate_ops_trailer_empty_hist FOREIGN KEY (trailer_empty_pickup_history_id, tenant) REFERENCES trailer_empty_pickup_history(id, tenant);
