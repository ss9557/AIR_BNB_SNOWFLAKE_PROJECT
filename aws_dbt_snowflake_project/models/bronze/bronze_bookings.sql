{{ 
    config(
        materialized='incremental',
        unique_key='BOOKING_ID'
    ) 
}}

SELECT * FROM {{ source('staging', 'bookings') }}

{% if is_incremental() %}
    WHERE CREATED_AT >= (SELECT COALESCE(MAX(CREATED_AT), '1900-01-01'::TIMESTAMP_NTZ) FROM {{ this }})
{% endif %}
