import BikeData from "./models/bike.model";
import claim from "./models/claim.model";
import comment from "./models/comments.model";
import Role from "./models/role.model";
import status from "./models/status.model";
import User from "./models/user.model";

export const seed = async () => {
	// clear db
	await claim.deleteMany({});
	await comment.deleteMany({});
	await Role.deleteMany({});
	await status.deleteMany({});
	await User.deleteMany({});
	await BikeData.deleteMany({});
	// seed db
	console.log('Seeding...');
	let todo = await status.findOne({ name: 'TODO' });
	if (!todo) {
		todo = new status({ name: 'TODO', color: '#FF0000' });
		await todo.save();
	}

	let inProgressStatus = await status.findOne({ name: 'INPROGRESS' });
	if (!inProgressStatus) {
		inProgressStatus = new status({ name: 'INPROGRESS', color: '#FFA500' });
		await inProgressStatus.save();
	}

	let doneStatus = await status.findOne({ name: 'DONE' });
	if (!doneStatus) {
		doneStatus = new status({ name: 'DONE', color: '#008000' });
		await doneStatus.save();
	}

	let stuckStatus = await status.findOne({ name: 'STUCK' });
	if (!stuckStatus) {
		stuckStatus = new status({ name: 'STUCK', color: '#0000FF' });
		await stuckStatus.save();
	}



	// get count of claims
	let count = await claim.countDocuments();
	if (count < 6) {
		const claim1 = new claim({ title: "Title 1", subject: 'Claim 1', message: 'Description 1', status: todo._id });
		const claim2 = new claim({ title: "Title 2", subject: 'Claim 2', message: 'Description 2', status: inProgressStatus._id });
		const claim3 = new claim({ title: "Title 3", subject: 'Claim 3', message: 'Description 3', status: doneStatus._id });
		await claim1.save();
		await claim2.save();
		await claim3.save();

	}

	const role1 = new Role({ name: 'Admin' });
	const role2 = new Role({ name: 'Super Admin' });
	const role3 = new Role({ name: 'SAV Manager' });
	const role4 = new Role({ name: 'SAV Technician' });
	const role5 = new Role({ name: 'Scooter Owner' });
	await role1.save();
	await role2.save();
	await role3.save();
	await role4.save();
	await role5.save();

	// check if user exists
	let user =
		await User.findOne({ email: 'superadmin@email.com' });
	if (!user) {
		const user1 = new User({ name: 'Super Admin', username: 'superadmin@email.com', email: "superadmin@email.com", password: '$2y$10$P7nCf1/YICmeK9EyY3h3YuwVdRnAf1jTw6Uujsh2ub3.vdLux.OzS', roles: [role1, role2], status: 1 });
		await user1.save();
	}
	user = await User.findOne({ email: 'admin@email.com' });
	if (!user) {
		const user2 = new User({ name: 'Admin', username: 'admin@email.com', email: "admin@email.com", password: '$2y$10$P7nCf1/YICmeK9EyY3h3YuwVdRnAf1jTw6Uujsh2ub3.vdLux.OzS', roles: [role2], status: 1 });
		await user2.save();
	}
	user = await User.findOne({ email: 'savmanager@email.com' });
	if (!user) {
		const user3 = new User({ name: 'SAV Manager', username: 'savmanager@email.com', email: "savmanager@email.com", password: '$2y$10$P7nCf1/YICmeK9EyY3h3YuwVdRnAf1jTw6Uujsh2ub3.vdLux.OzS', roles: [role3], status: 1 });
		await user3.save();
	}
	user = await User.findOne({ email: 'savtechnician@email.com' });
	if (!user) {
		const user4 = new User({ name: 'SAV Technician', username: 'savtechnician@email.com', email: "savtechnician@email.com", password: '$2y$10$P7nCf1/YICmeK9EyY3h3YuwVdRnAf1jTw6Uujsh2ub3.vdLux.OzS', roles: [role4], status: 1 });
		await user4.save();
	}
	user = await User.findOne({ email: 'scooterowner@email.com' });
	if (!user) {

		const user5 = new User({ name: 'Scooter Owner', username: 'scooterowner@email.com', email: "scooterowner@email.com", password: '$2y$10$P7nCf1/YICmeK9EyY3h3YuwVdRnAf1jTw6Uujsh2ub3.vdLux.OzS', roles: [role5], status: 1 });
		await user5.save();
	}

	let BatteryH = [];
	let now= new Date(2020, 4, 30);
	let oneDay = 24 * 60 * 60 * 1000;	
	for (let i = 0; i < 100; i++) {
		now = new Date(now.getTime() + oneDay);
	
		BatteryH.push({
			// date increase by 1 day
			// date format: Sun Aug 03 2022 00:00:00 GMT+0100 (heure normale d’Europe centrale)
			name: now.toString(),
			value: [
				[now.getFullYear(), now.getMonth() + 1, now.getDate()].join('/'),
				Math.floor(Math.random() * 100),
			],
		});
	}
	

	// console.log(BatteryH);
	const bike1 = new BikeData({
		id: "12345678",
		SysPower: true,
		date: new Date("2022-01-01T00:00:00.000Z"),
		location: {
			latitude: 11.111011,
			longitude: 33.504214,
			altitude: 0,
			heading: 0,
			speed: 0,
			accuracy: 0,
		},
		BatteryStatus: true,
		BatteryCap: 80,
		BatteryHistory: BatteryH,
		Range: 100,
		BluetoothOp: true,
		BluetoothCon: true,
		TheftState: false,
		SystemSOS: false,
		UserSOS: false,
	});
	await bike1.save();

	const bike2 = new BikeData({
		id: "12345679",
		SysPower: true,
		date: new Date("2022-03-01T00:00:00.000Z"),
		location: {
			latitude: 11.111011,
			longitude: 33.504214,
			altitude: 0,
			heading: 0,
			speed: 0,
			accuracy: 0,
		},
		BatteryStatus: true,
		BatteryCap: 80,
		BatteryHistory: BatteryH,
		Range: 100,
		BluetoothOp: true,
		BluetoothCon: true,
		TheftState: false,
		SystemSOS: false,
		UserSOS: false,
	});

	await bike2.save();

	const bike3 = new BikeData({
		id: "12345680",
		SysPower: true,
		date: new Date("2022-05-01T00:00:00.000Z"),
		location: {
			latitude: 11.111011,
			longitude: 33.504214,
			altitude: 0,
			heading: 0,
			speed: 0,
			accuracy: 0,
		},
		BatteryStatus: true,
		BatteryCap: 70,
		BatteryHistory: BatteryH,
		Range: 100,
		BluetoothOp: true,
		BluetoothCon: true,
		TheftState: false,
		SystemSOS: false,
		UserSOS: false,
	});

	await bike3.save();
	// console.log(bike1._id);
	// console.log(bike2._id);
	// console.log(bike3._id);
	

	console.log('Seeding done');

}