import claim from "./models/claim.model";
import comment from "./models/comments.model";
import status from "./models/status.model";

export const seed = async () => {
	console.log('Seeding...');
	let todo = await status.findOne({ name: 'TODO' });
	if (!todo) {
		todo = new status({ name: 'TODO' });
		await todo.save();
	}

	let inProgressStatus = await status.findOne({ name: 'INPROGRESS' });
	if (!inProgressStatus) {
		inProgressStatus = new status({ name: 'INPROGRESS' });
		await inProgressStatus.save();
	}

	let doneStatus = await status.findOne({ name: 'DONE' });
	if (!doneStatus) {
		doneStatus = new status({ name: 'DONE' });
		await doneStatus.save();
	}

	let stuckStatus = await status.findOne({ name: 'STUCK' });
	if (!stuckStatus) {
		stuckStatus = new status({ name: 'STUCK' });
		await stuckStatus.save();
	}



	// get count of claims
	let count = await claim.countDocuments();
	if (count < 6) {
		const claim1 = new claim({ subject: 'Claim 1', message: 'Description 1', status: todo._id });
		const claim2 = new claim({ subject: 'Claim 2', message: 'Description 2', status: inProgressStatus._id });
		const claim3 = new claim({ subject: 'Claim 3', message: 'Description 3', status: doneStatus._id });
		await claim1.save();
		await claim2.save();
		await claim3.save();
		
	}

	console.log('Seeding done');

}