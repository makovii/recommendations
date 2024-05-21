import { ApolloServer } from '@apollo/server';
import { startStandaloneServer } from '@apollo/server/standalone';
import { Neo4jGraphQL } from "@neo4j/graphql";
import neo4j from "neo4j-driver";
import 'dotenv/config'

const typeDefs = `#graphql
    type Movie {
        title: String
        released: Int
        tagline: String
    }

    type User {
        uid: String!
        name: String
        email: String!
        createdTime: DateTime!
        isNewUser: Boolean
        dateOfBirth: DateTime
    }

    input CreateUserInput {
        uid: String!
        name: String
        email: String!
        createdTime: DateTime!
        isNewUser: Boolean
        dateOfBirth: DateTime
    }

    type Mutation {
        createUser(input: CreateUserInput): User
    }

    type Query {
        users: [User]
    }
    
`;



const driver = neo4j.driver(
    process.env.NEO4J_URL,
  neo4j.auth.basic(process.env.NEO4J_USER, process.env.NEO4J_PASSWORD)
);

const resolvers = {
    Mutation: {
        createUser: async (_, { input }, context) => {
            // console.log('createUser input:', input);
            const session = context.driver.session();
            try {
                const result = await session.run(
                    `CREATE (u:User { 
                        uid: $uid, 
                        name: $name, 
                        email: $email, 
                        createdTime: datetime($createdTime), 
                        isNewUser: $isNewUser, 
                        dateOfBirth: datetime($dateOfBirth) 
                    }) RETURN u`,
                    input
                );
                const user = result.records[0].get('u').properties;
                // console.log('createUser result:', user);
                return user;
            } catch (error) {
                console.error('Error creating user:', error);
                throw new Error('Error creating user');
            } finally {
                await session.close();
            }
        },
    },
};

const neoSchema = new Neo4jGraphQL({ typeDefs, resolvers, driver, config: { debug: true } });

const server = new ApolloServer({
    schema: await neoSchema.getSchema(),
});

const { url } = await startStandaloneServer(server, {
    context: async ({ req }) => ({ driver, req }),
    listen: { port: 4000 },
});

console.log(`🚀 Server ready at ${url}`);

