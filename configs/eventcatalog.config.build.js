const path = require('path');
const fs = require('fs');

/**
 * @description This is the configuration for each schema and generator.
 */
const config = {
  versionEvents: true,
  renderMermaidDiagram: false,
  renderNodeGraph: true
}

/**
 * @description Produce the generators needed dynamically.
 */
const createGenerators = (schemaFolder = 'schemas') => {
  const schemasOnDisk = fs.readdirSync(path.join(__dirname, schemaFolder));
  const schemas = schemasOnDisk.filter((fileName) => fileName.includes('.json'));
  if (!schemas) return [];

  return schemas.map((schemaName) => {
    return [
      '@eventcatalog/plugin-doc-generator-asyncapi',
      {
        ...config,
        domainName: schemaName.split('.')[0],
        pathToSpec: path.join(__dirname, `${schemaFolder}/${schemaName}`),
      },
    ]
  });
}

/**
 * @description Create all users to be referenced in EventCatalog.
 */
const createUsers = () => {
  return [
    {
      id: 'Sam Person',
      name: 'Sam Person',
      role: 'Some Person Somewhere',
      avatarUrl: ''
    },
    {
      id: 'John Doe',
      name: 'John Doe',
      role: 'Some Person Somewhere',
      avatarUrl: ''
    },
  ]
}

/**
 * @description Export the configuration.
 * @note The "undefined" `eventCatalogConfig` here is added at runtime by one of the packaging scripts.
 */
module.exports = {
  ...eventCatalogConfig,
  users: createUsers(),
  generators: createGenerators('schemas')
}
