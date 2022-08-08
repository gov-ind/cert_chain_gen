open('intermediate.pem', 'r').read().split('-----BEGIN CERTIFICATE-----')[1].split('-----END CERTIFICATE-----')[0].strip().replace('\n', '')
