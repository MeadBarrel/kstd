set __WARP to True.
set __ASSERT_STRICT to True.
set __CONTRACTS to True.
set __ENODE_MARGIN to 15.

run once _core.
switch to 1.

download_ine("_core.ks"). run once _core.
if exists("_startup.ks") run _startup.

