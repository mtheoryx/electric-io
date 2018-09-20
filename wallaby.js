module.exports = function(wallaby) {
  return {
    files: [
      './index.js',
      { pattern: './**/*.test.js', ignore: true },
      { pattern: 'node_modules/*', ignore: true }
    ],
    tests: [
      './index.test.js',
      { pattern: 'node_modules/*', ignore: true }
    ],
    testFramework: 'jest',
    debug: true,
    env: {
      type: 'node',
      runner: 'node'
    }
  };
}