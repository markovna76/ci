module.exports = {
  types: [
    { value: 'feat',     name: 'feat:     Changes which introduce a new feature' },
    { value: 'fix',      name: 'fix:      Changes which patch a bug' },
    { value: 'docs',     name: 'docs:     Changes which affect documentation' },
    { value: 'style',    name: 'style:    Changes which don\'t affect code logic.\n            White-spaces, formatting, missing semi-colons, etc'},
    { value: 'refactor', name: 'refactor: Changes which neither fix a bug nor add a feature'},
    { value: 'perf',     name: 'perf:     Changes which improve performance'},
    { value: 'test',     name: 'test:     Changes which add missing tests or correct existing tests' },
    { value: 'chore',    name: 'chore:    Changes to the build process or auxiliary tools\n            and libraries such as documentation generation\n            no production code change',
    },
  ],

  // should be filled automatically by using 'git log --all --format=%s' and reg exp '^[a-z]+\(([^)]+)\\):.*'
  scopes: [],

  allowTicketNumber: true,
  isTicketNumberRequired: true,
  ticketNumberPrefix: 'related to #',
  ticketNumberRegExp: '\\d{1,8}',

  // it needs to match the value for field type. Eg.: 'fix'
/*
  scopeOverrides: {
    fix: [
      {name: 'logic'},
      {name: 'bug'},
      {name: 'test'},
      {name: ''}
    ]
  },
*/
  // override the messages, defaults are as follows
  messages: {
    type: "Select the type of change that you're committing:",
    scope: '\nDenote the SCOPE of this change (optional):',
    // used if allowCustomScopes is true
    customScope: 'Denote the SCOPE of this change:',
    subject: 'Write a SHORT, IMPERATIVE tense description of the change:\n',
    body: 'Provide a LONGER description of the change (optional). Use "|" to break new line:\n',
    breaking: 'List any BREAKING CHANGES (will increase main version) (optional):\n',
    footer: 'List any ISSUES CLOSED by this change (optional). E.g.: #31, #34:\n',
    confirmCommit: 'Are you sure you want to proceed with the commit above?',
  },

  allowCustomScopes: true,
  allowBreakingChanges: ['feat', 'fix'],
  // skip any questions you want
  // skipQuestions: ['footer'],

  // limit subject length
  subjectLimit: 100,
  // breaklineChar: '|', // It is supported for fields body and footer.
  footerPrefix : 'CLOSES  '
  // askForBreakingChangeFirst : true, // default is false
};

