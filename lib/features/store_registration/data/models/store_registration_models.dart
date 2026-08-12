/// Payload for the self-service store-creation endpoint (`POST /stores/register`).
/// The backend provisions a live shop + owner account + subdomain and returns an
/// `AuthResult` (access token + user) so the caller is signed in immediately.
///
/// `subdomainLabel` is the platform subdomain (e.g. `myshop` → `myshop.<base>`);
/// `customDomain` is an optional own-domain kept pending until verified.
///
/// Plain immutable class (no `@freezed`): it is only constructed and read — the
/// service hand-builds the request map — so it needs no copyWith/equality/JSON
/// codegen, which also keeps it independent of the build_runner toolchain.
class RegisterStoreRequest {
  final String shopName;
  final String ownerName;
  final String? phone;
  final String? whatsApp;
  final String? city;
  final String? country;
  final String? businessType;
  final String? description;
  final String subdomainLabel;
  final String? customDomain;
  final String email;
  final String password;

  const RegisterStoreRequest({
    required this.shopName,
    required this.ownerName,
    this.phone,
    this.whatsApp,
    this.city,
    this.country,
    this.businessType,
    this.description,
    required this.subdomainLabel,
    this.customDomain,
    required this.email,
    required this.password,
  });
}
