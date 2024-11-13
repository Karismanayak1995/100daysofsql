--Your task is to write a SQL query to generate a trip ID for each customer based on the hotel bookings data.
--In a single trip, a customer can check in and check out at multiple hotels. 
--However, if the check-in date at a hotel is within 1 day of the previous check-out date, it will be considered as the same trip.
--The first 3 bookings will be considered in the same trip and last booking will be a new trip.
--Write an SQL to genrate trip numbers starting from 1 for each customer, trip start date and trip end date.
-----------------------------------------------------------------------------

SELECT * FROM hotelbookings_71
-------------------------------------------
WITH bookingno AS 
     (
		 SELECT customerid,
		        checkindate,
		        checkoutdate,
                ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY checkindate) AS BookingNumber
      
         FROM hotelbookings_71
		 )
,trip_details AS 
      (
		  SELECT customerid,
		  checkindate,
		  checkoutdate,
		  (BookingNumber - 1 ) /3 AS trip_group --Create a new trip every 3 bookings
		  
		  FROM bookingno
	  )
--SELECT * FROM trip_details
SELECT customerid,
       trip_group + 1 AS tripnumber,
	   MIN(checkindate) AS tripstartdate,
	   MAX(checkoutdate) AS tripenddate
FROM trip_details	   
GROUP BY customerid , trip_group 
ORDER BY customerid, tripnumber