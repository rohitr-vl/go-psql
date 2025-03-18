package main

import (
	"context"
	"log"
	"reflect"
	"strconv"
	"time"

	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgtype"

	"tutorial.sqlc.dev/app/tutorial"
)

func run() error {
	ctx := context.Background()

	conn, err := pgx.Connect(ctx, "user=postgres password=super369 dbname=fleet_track_mgmt sslmode=disable")
	// conn, err := pgx.Connect(ctx, "postgres://postgres:super369@localhost:5432/fleet_track_mgmt")
	if err != nil {
		return err
	}
	defer conn.Close(ctx)

	queries := tutorial.New(conn)

	// list all authors
	drivers, err := queries.DriverList(ctx)
	if err != nil {
		return err
	}
	log.Println(drivers)
	
	// create an author
	insertedDriver, err := queries.CreateDriver(ctx, tutorial.CreateDriverParams{
		FullName: "Brian Kernighan",
		PhoneNumber: "123-456-7890",
		Email: "bkern@vl.com",
		PermanentAddress: "1234 Elm St, Springfield, IL 62701",
		LicenseNumber: "DL-4567890",
		LicenseValidUntil: pgtype.Date{Time: time.Date(2029, 12, 30, 0, 0, 0, 0, time.UTC), Valid: true},
		IsAvailable: true,
		IsActive: true,
	})
	if err != nil {
		return err
	}
	log.Println(insertedDriver)

	// get the author we just inserted
	fetchedDriver, err := queries.GetDriver(ctx, strconv.FormatInt(int64(insertedDriver.ID), 10))
	if err != nil {
		return err
	}

	// prints true
	log.Println(reflect.DeepEqual(insertedDriver, fetchedDriver))
	return nil
}

func main() {
	if err := run(); err != nil {
		log.Fatal(err)
	}
}