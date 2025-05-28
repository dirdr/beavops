if ! command -v htpasswd &>/dev/null; then
  echo "Error: htpasswd not found. Please install apache2-utils package:"
  echo "  Debian/Ubuntu: sudo apt-get install apache2-utils"
  echo "  CentOS/RHEL: sudo yum install httpd-tools"
  echo "  Alpine: apk add apache2-utils"
  exit 1
fi

USERNAME="admin"
PASSWORD=""
GENERATE_PASSWORD=true

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
  case $1 in
  --username)
    USERNAME="$2"
    shift 2
    ;;
  --password)
    PASSWORD="$2"
    GENERATE_PASSWORD=false
    shift 2
    ;;
  *)
    echo "Unknown option: $1"
    exit 1
    ;;
  esac
done

if [ "$GENERATE_PASSWORD" = true ]; then
  # Generate a strong 16-character password
  PASSWORD=$(LC_ALL=C tr -dc 'A-Za-z0-9!#%&()*+,-./:;<=>?@[\]^_{|}~' </dev/urandom | head -c 16)
fi

HASHED_CREDENTIALS=$(htpasswd -nbB "$USERNAME" "$PASSWORD")

# For Docker Compose .env files, we need to escape $ signs with another $
# This handles the $$ escaping correctly for multiple layers
ESCAPED_CREDENTIALS=$(echo "$HASHED_CREDENTIALS" | sed 's/\$/\$\$/g')

echo "Credentials generated successfully!"
echo "Username: $USERNAME"
echo "Password: $PASSWORD"
echo
echo "Raw htpasswd output: $HASHED_CREDENTIALS"
echo "Escaped for .env: $ESCAPED_CREDENTIALS"
echo
echo "Note: Store this password securely. This will be displayed only once."
echo "You may want to clear your terminal history after copying these details."
