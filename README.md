# M05W11 - Database Design

Edit: 12/17/2023

### To Do
- [ ] Primary Keys/Foreign Keys
- [ ] Naming Conventions
- [ ] Data Types
- [ ] Relationship Types
- [ ] Some Design Best Practices
- [ ] Entity Relationship Diagrams
- [ ] ERD Example

### DB Synonyms Galore
- Table == Relation ~= Entity
- Row == Record == Tuple
- Column == Field == Attribute

### Data Types
- Each column in a table **must** have a [data type](https://www.postgresql.org/docs/16/datatype.html)
- The data type tells the database how much room to set aside for the value, so prefer small BUT sensible data type for a column (e.g. fixed `VARCHAR` vs arbitrary `TEXT`, `INTEGER` vs `BIGINT`)
- The data type allows the database to perform type validation on data before insertion (data integrity)
- Be careful, e.g. time is soon a problem if stored as 32-bit integer: https://en.wikipedia.org/wiki/Year_2038_problem

- Be careful, but start out simple and try not to overthink. Choosing the perfect data type is less of a concern nowadays (sensible framework defaults, cheap storage, better tools and practice, time-to-market, decision fatigue, changing requirements)
    * [Integer](https://www.postgresql.org/docs/current/datatype-numeric.html#DATATYPE-INT)
    * [Character](https://www.postgresql.org/docs/current/datatype-character.html)
    * [Date/Time](https://www.postgresql.org/docs/current/datatype-datetime.html)
    * [Boolean](https://www.postgresql.org/docs/current/datatype-boolean.html)

### Primary Key
- The unique identifier for a particular record within a table (`UNIQUE`)
- Can never be null (`NOT NULL`)
- The usual data type is auto-incrementing integer (preferably `BIGINT`, so use `BIGSERIAL`)
- A Primary Key stored in another table is known as a `Foreign Key` (they **MUST** be of the same data type)
- Automatically indexed, BUT indexes are not free (INSERT/UPDATE needs to update them all)

### Foreign Keys
- Represents the PK in another table (should be same data-type)
- Implement relationships (see "Entity Relationship Types")

#### Naming Conventions (at LHL)
- Table and column names in `snake_case`
- Table names are pluralized, e.g. `books, authors, books_authors`
- Primary key is `id`
- A foreign key is made up of the singular of the primary key's table and the suffix `_id` (eg. `user_id` is the foreign key for the `id` field in the `users` table)

### Entity Relationship Types
- **One-to-One**: One record in the first table is related to one (and only one) record in the second table.
- **One-to-Many**: One record in the first table is related to zero/one or more records in the second table.
  - If one album has many songs AND a song can only belong to an album, `songs` records keep a `album_id` field.
- **Many-to-Many**: One or more records in the first table are related to zero/one or more records in the second table (through many records on the join table)
  - If one album has many songs AND a song can be in many albums: see `music.sql` for an example with a **join table**

- One-to-Many and Many-to-Many relationships are the most common. One-to-One's are less common but conceptually useful.

### Entity Relationship Diagram (ERD)
- A visual depiction of the database tables and their relationships
- Useful for reasoning about database structure
- [diagrams.net](https://app.diagrams.net/) or [dbdiagram.io](https://dbdiagram.io/)

### Some Good Ideas in Database Design
- Real-world entities and relationships are rarely simple (see common [falsehoods](https://github.com/kdeldycke/awesome-falsehood)). Start simple but strive to be flexible and maintainable.
- Deliberate on the nature of relationship of entities (e.g. create an `orders` table with an `order_type` field vs. separate `purchase_orders` and `sales_orders` tables).
- [Normalization](https://en.wikipedia.org/wiki/Database_normalization#Example_of_a_step-by-step_normalization) is a common design techniques to reduce redudant data fields. See the first 3 forms of normalization (forms beyond that is rare in practice).
  - The typical normationalization technique is to pull repeated values out to their own table/entity and make references to them with a foreign key (e.g. a `genres` table for songs)
- [Default values](https://www.postgresql.org/docs/16/ddl-default.html). For example, `created_at`/`updated_at = NOW()`, `active = true`
- [Required fields](https://www.postgresql.org/docs/16/ddl-constraints.html). In production apps, `NOT NULL` is generally a good constraint to add liberally, as a field can easily be made optional later (by removing that constraint) but not easily made required (What if existing data does not have a value for that field? How should they be back-filled?).
- Consider deletion strategies (soft vs. hard delete). Consider using a `deleted` (or `deleted_at`) flag or set up [soft delete triggers](https://web.archive.org/web/20210617191053/https://medium.com/meroxa/creating-a-soft-delete-archive-table-with-postgresql-70ba2eb6baf3).
- Research carefully the appropriate data type for business-critical entities (e.g. [money in PostgreSQL is not recommended](https://wiki.postgresql.org/wiki/Don't_Do_This#Don.27t_use_money)).

### Useful Links
* [Postgres Data Types](https://www.postgresql.org/docs/16/datatype.html/)
* [Relationship Types](http://etutorials.org/SQL/Database+design+for+mere+mortals/Part+II+The+Design+Process/Chapter+10.+Table+Relationships/Types+of+Relationships/)
* [diagrams.net (formerly draw.io)](https://app.diagrams.net/) or [dbdiagram.io](https://dbdiagram.io/)
* [Falsehoods Programmers believe about names with examples](https://shinesolutions.com/2018/01/08/falsehoods-programmers-believe-about-names-with-examples/)
