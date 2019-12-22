## GOCOVER.DEV

Feature list:
  - Only GET queries (`https://gocover.dev/{repo}`)
  - hash-based cache
  - badges from cache
  - webhook-based cache refresh (implies "registration")
  - option: test ./...
  - option: show output
  - option: select go version
  - stats: most covered entries
  - stats: most frequently tested/updated entries
  - stats: most recent entries
  - stats: largest codebase
  - stats: ???

Endpoints:
  - `gocover.dev/cover/{repo}` manual coverage 
    - go version
    - deep test
    - short test
  - `gocover.dev/badge/{repo}` get badge
    - page url:
      - {repo} = master/HEAD
      - {repo}/tree/{branch} = branch/HEAD
      - {repo}/tree/{tag} = tag/HEAD
  - `gocover.dev/hook/{repo}` webhook handler
  - `gocover.dev/register/` register
  - `gocover.dev/add/` add webhook for repo
  - `gocover.dev/about/` add webhook for repo

Roadmap:
  - index page
    - template
    - gocover.dev/{repo} redirect
  - docker exec
    - run script
	- output reading and transfer
  - cache based on TNT
    - tnt API
	- go wrapper
  - result display
    - html parsing

Maybe list:
  - pprof
