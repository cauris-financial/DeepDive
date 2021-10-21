var DeepDive = artifacts.require("DeepDive");

module.exports = function (deployer) {
	// deployment steps
	deployer.deploy(DeepDive);
};
