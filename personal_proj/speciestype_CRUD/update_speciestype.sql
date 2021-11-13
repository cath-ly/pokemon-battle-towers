-- updating poketype if the poke_id changes types through evolution
UPDATE species_type SET 
... = [NULL|DEFAULT|<value_expression>],
... = [NULL|DEFAULT|<value_expression>],
...
WHERE type_id = ??? AND species_name = ???;