export class Bike {
	id: string;
	SysPower: boolean;
	date: Date;
	location: {
		latitude: number,
		longitude: number,
		altitude: number,
		heading: number,
		speed: number,
		accuracy: number,
	};
	BatteryStatus: boolean;
	BatteryCap: number;
	Range: number;
	BluetoothOp: boolean;
	BluetoothCon: boolean;
	TheftState: boolean;
	SystemSOS: boolean;
	UserSOS: boolean;
	constructor(
		id: string,
		SysPower: boolean,
		date: Date,
		location: {
			latitude: number,
			longitude: number,
			altitude: number,
			heading: number,
			speed: number,
			accuracy: number,
		},
		BatteryStatus: boolean,
		BatteryCap: number,
		Range: number,
		BluetoothOp: boolean,
		BluetoothCon: boolean,
		TheftState: boolean,
		SystemSOS: boolean,
		UserSOS: boolean,
	) {
		this.id = id;
		this.SysPower = SysPower;
		this.date = date;
		this.location = location;
		this.BatteryStatus = BatteryStatus;
		this.BatteryCap = BatteryCap;
		this.Range = Range;
		this.BluetoothOp = BluetoothOp;
		this.BluetoothCon = BluetoothCon;
		this.TheftState = TheftState;
		this.SystemSOS = SystemSOS;
		this.UserSOS = UserSOS;
	}

}
