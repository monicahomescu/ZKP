pragma circom 2.0.0;

include "../node_modules/circomlib/circuits/poseidon.circom";

template VerifyCredentials(passwordLength) {
    // public inputs
    signal input username;
    signal input hashedCredentials;

    // private inputs
    signal input password[passwordLength];

    component hash = Poseidon(passwordLength + 1);
    hash.inputs[0] <== username;
    for (var i = 0; i < passwordLength; i++) {
        hash.inputs[i + 1] <== password[i];
    }

    hash.out === hashedCredentials;
}

component main {public[username, hashedCredentials]} = VerifyCredentials(4);