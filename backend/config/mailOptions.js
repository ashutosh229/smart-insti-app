const subjectOTPLogin = "OTP for Login";

function createOTPEmailBody(otp) {
  return `Your OTP for login is: ${otp}`;
}

export const dbName = "test";
export const otpCollectionName = "otpCollection";

export function getMailOptions(recieverMail, otp) {
  const mailOptions = {
    from: process.env.SENDER_EMAIL,
    to: recieverMail,
    subject: subjectOTPLogin,
    text: createOTPEmailBody(otp),
  };

  return mailOptions;
}
