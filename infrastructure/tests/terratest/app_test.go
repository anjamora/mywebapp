// ec2_test.go

package test

import (
	"fmt"
	"testing"
	"time"

	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestTerraformWebappTesting(t *testing.T) {
	t.Parallel()

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		// Set the path to the Terraform code that will be tested.
		TerraformDir: "../../app",
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	instance_ip_addr := terraform.Output(t, terraformOptions, "instance_ip_addr")

	url := fmt.Sprintf("http://%s:8080", instance_ip_addr)
	http_helper.HttpGetWithRetry(t, url, nil, 200, "Hello, Maya!", 30, 5*time.Second)
}
