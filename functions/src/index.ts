import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp();


export const addDeductions = functions.firestore
  .document('deductions/{Item}')
  .onCreate(async snapshot => {
  const dedsDocumentReference = admin.firestore().doc('company/pelt');

  const dedsDocumentSnapshot = await dedsDocumentReference.get();
  const currentDeds = dedsDocumentSnapshot.get( 'deductions');
  const newDeds = currentDeds + 1;

  return dedsDocumentReference.update({deductions : newDeds });

  });

  export const addIssuance = functions.firestore
    .document('issuance/{Item}')
    .onCreate(async snapshot => {
    const issuanceDocumentReference = admin.firestore().doc('company/pelt');

    const issuanceDocumentSnapshot = await issuanceDocumentReference.get();
    const currentissuance = issuanceDocumentSnapshot.get( 'issuance');
    const newissuance = currentissuance + 1;

    return issuanceDocumentReference.update({issuance : newissuance });

    });