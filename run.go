package main

import (
	"context"
	"log"
	"reflect"

	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgtype"
	"golang.org/x/text/date"

	"tutorial.sqlc.dev/app/tutorial"
)

func run() error {
	ctx := context.Background()

	conn, err := pgx.Connect(ctx, "user=pqgotest dbname=pqgotest sslmode=verify-full")
	if err != nil {
		return err
	}
	defer conn.Close(ctx)

	queries := tutorial.New(conn)

	// list all authors
	authors, err := queries.DriverList(ctx)
	if err != nil {
		return err
	}
	log.Println(authors)

	// create an author
	insertedAuthor, err := queries.CreateDriver(ctx, tutorial.CreateDriverParams{
		full_name: "Brian Kernighan",
		phone_number: "123-456-7890",
		email: "bkern@vl.com",
		permanent_address: "1234 Elm St, Springfield, IL 62701",
		license_number: "DL-4567890",
		license_valid_until: pgtype.Date{Time: date.New(2023, 1, 1, 0, 0, 0, 0, time.UTC), Status: pgtype.Present},
		primary_alert: "",
		is_available: true,
		is_active: true,
		created_at: 
	})
	if err != nil {
		return err
	}
	log.Println(insertedAuthor)

	// get the author we just inserted
	fetchedAuthor, err := queries.GetAuthor(ctx, insertedAuthor.ID)
	if err != nil {
		return err
	}

	// prints true
	log.Println(reflect.DeepEqual(insertedAuthor, fetchedAuthor))
	return nil
}

func main() {
	if err := run(); err != nil {
		log.Fatal(err)
	}
}