SPACESHIP_PROMPT_ASYNC=true
SPACESHIP_PROMPT_ADD_NEWLINE=true
SPACESHIP_PROMPT_FIRST_PREFIX_SHOW=false
SPACESHIP_RPROMPT_FIRST_PREFIX_SHOW=true

SPACESHIP_TIME_SHOW=true
SPACESHIP_TIME_FORMAT='%D{%H:%M:%S}'

SPACESHIP_USER_SHOW=never
SPACESHIP_DIR_TRUNC_REPO=true
SPACESHIP_ASYNC_SHOW_COUNT=true

SPACESHIP_KUBECTL_SHOW=true

# left prompt
SPACESHIP_PROMPT_ORDER=(
  time           # Time stamps section
  dir            # Current directory section
  async
  git            # Git section (git_branch + git_status)
  async
  kubectl        # Kubectl context section
  async
  aws            # Amazon Web Services section
  line_sep       # Line break
  char           # Prompt character
)

# right prompt
SPACESHIP_RPROMPT_ORDER=(
)