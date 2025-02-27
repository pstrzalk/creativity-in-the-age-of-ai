# The Joy of Creativity in the age from AI

A repository containing the presentation from Ruby Community Conference, Winter 2025 edition in Cracow.

## Slides

The slides are stored as seeds, so please remember to run `rails db:seed` once your DB is created.

## ENV variables

Be sure to add a dotenv file with the definition of OpenAI API key as OPENAI_API_KEY variable.

## Running

Run with `bin/dev`, not `rails s` to enable compilation of TailwindCSS
Solid queue is plugin is enable in Puma, so you don't need to run it separately.

## VERY VERY VERY IMPORTANT

The repository DOES NOT CONTAIN the 3d model of Corgi used in the presentation.
It is not a public model, but you may buy it at https://www.fab.com/listings/937d7712-a94b-43a6-b272-b17bb560dd03 and add to the project.
When you have the model in GLTF format, extract its contents (corgi_gltf folder) to /public
