module.exports = {
    preset: 'jest-preset-angular',
    setupFilesAfterEnv: ['<rootDir>/src/setup-jest.ts'],
    reporters: [
      'default',
      [
        'jest-junit',
        {
          outputDirectory: 'test-results/jest',
          outputName: 'results.xml',
        },
      ],
    ],
  };
  