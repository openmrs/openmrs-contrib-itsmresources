import os
import testinfra.utils.ansible_runner
import pytest

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


@pytest.fixture()
def config_file(host):
    return host.file('/root/.aws/config')


@pytest.fixture()
def credentials_file(host):
    return host.file('/root/.aws/credentials')


def test_aws_cli_should_be_installed(host):
    assert host.run('aws --v').rc == 0


def test_aws_cli_files_should_exist(host, config_file, credentials_file):
    assert config_file.exists, credentials_file.exists


def test_region_configured_json_output(host, config_file, credentials_file):
    assert config_file.contains(
        '''
        [sa]
        region = sa-east-1
        output = json
        '''
    )

    assert credentials_file.contains(
        '''
        [sa]
        aws_access_key_id = AKIAIOSDNKOW73X4MPL3
        aws_secret_access_key = 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
        '''
    )


def test_region_configured_text_output(host, config_file, credentials_file):
    assert config_file.contains(
        '''
        [cn]
        region = cn-north-1
        output = text
        '''
    )

    assert credentials_file.contains(
        '''
        [cn]
        aws_access_key_id = AKIAIOSDNKOW7EXAMPLE
        aws_secret_access_key = wJalrXUtnFEMI/F3GXCLG/bPxRfiCYEXAMPLEKEY
        '''
    )


def test_no_aws_access_key_id_configured_aws_secret_access_key(
        host, credentials_file):
    assert credentials_file.contains(
        '''
        [no_aws_access_key_id]
        aws_secret_access_key = wJalrXUtnFEMI/F3GXCLG/bPxRfiCY3XXMPL3K3Y
        '''
    )


def test_no_aws_secret_key_configured_aws_key_id(host, credentials_file):
    assert credentials_file.contains(
        '''
        [no_aws_secret_access_key]
        aws_key_id = AKIAIOSDNKOW73XXMPL3
        '''
    )


def test_no_region_configured_json_output(host, config_file):
    assert config_file.contains(
        '''
        [no_region]
        output = test
        '''
    )


def test_no_output_configured_region(host, config_file):
    assert config_file.contains(
        '''
        [no_output]
        region = eu-central-1
        '''
    )
