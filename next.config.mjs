/** @type {import('next').NextConfig} */
const nextConfig = {
  async redirects() {
    return [{ source: "/index", destination: "/", permanent: false }];
  },
};

export default nextConfig;
