PROGRAM linkedlists;
USES sysutils, Crt;

TYPE
	TUserRec = RECORD
		Name, Surname, Email, Password: String;
		Id, Age: Integer;
		Sex: Char;
	END;

	TNodePtr = ^TNode;

	TNode = RECORD
		UserRec: TUserRec;
		NodePtr: TNodePtr;
	END;

VAR
	Head, Tail: TNodePtr;
	SampleRecord: TUserRec;
	Email, Password: String;
	isAuth: Boolean;

procedure InitLinkedList;
	begin
		Head := nil;
		Tail := Head;
	end;

procedure AddRecord(UserRec: TUserRec);
	var
	Node: TNode;

	begin
		Node.UserRec := UserRec;
		New(Node.NodePtr);

		if Head = nil then
		begin
			New(Head);
			New(Tail);
			Head^ := Node;
		end else
		begin
			Tail^.NodePtr^ := Node;
		end;

		Tail^ := Node;
	end;

procedure InsertRecordByIndex(Index: Integer; UserRec: TUserRec);
	var
		i: Integer;
		TempPtr: TNodePtr;
		Node, TempNode: TNode;
		Done: Boolean;

	begin
		Done := False;

		if Head = nil then
			Exit;

		i := 0;
		TempPtr := Head;
		Node.UserRec := UserRec;
		New(Node.NodePtr);

		if (Index = 0) then
		begin
			TempNode := Head^;
			Head^ := Node;
			Node.NodePtr^ := TempNode;
			Done := True;
		end;

		if not Done then
			while (i < Index-1) do
			begin
				if (TempPtr^.NodePtr^.NodePtr = nil) then
				begin
					Done := True;
					Break;
				end;

				i := i + 1;
				TempPtr := TempPtr^.NodePtr;
			end;

		if not Done then
		begin
			TempNode := TempPtr^.NodePtr^;
			TempPtr^.NodePtr^ := Node;
			Node.NodePtr^ := TempNode;
		end;
	end;

procedure InsertRecordByID(ID: Integer; UserRec: TUserRec);
	var
		TempPtr: TNodePtr;
		Node, TempNode: TNode;
		Done: Boolean;

	begin
		Done := False;

		if Head = nil then
			Exit;

		TempPtr := Head;
		Node.UserRec := UserRec;
		New(Node.NodePtr);

		if (TempPtr^.UserRec.ID = ID) then
		begin
			TempNode := Head^;
			Head^ := Node;
			Node.NodePtr^ := TempNode;
			Done := True;
		end;

		while not Done do
		begin
			if (TempPtr^.UserRec.ID = ID) then
				Break;

			if (TempPtr^.NodePtr^.NodePtr = nil) then
			begin
				Done := True;
				Break;
			end;

			TempPtr := TempPtr^.NodePtr;
		end;

		if not Done then
		begin
			TempNode := TempPtr^.NodePtr^;
			Node.NodePtr^ := TempNode;
			TempPtr^.NodePtr^ := Node;
		end;
	end;

procedure DeleteNodeWithID(ID: Integer);
	var
		TempPtr, PrevPtr: TNodePtr;
		Done: Boolean;

	begin
		Done := False;

		if Head = nil then
			Exit;

		PrevPtr := Head;
		TempPtr := Head;

		while True do
		begin
			if (TempPtr^.UserRec.ID = ID) then
				Break;

			if (TempPtr^.NodePtr^.NodePtr = nil) then
			begin
			Done := True;
			Break;
			end;

			PrevPtr := TempPtr;
			TempPtr := TempPtr^.NodePtr;
		end;
		if not Done then
		begin
			if TempPtr = Head then
				Head := Head^.NodePtr
			else
			begin
				PrevPtr^.NodePtr := TempPtr^.NodePtr;
			end;
		end;
	end;

procedure PrintAll(Head: TNodePtr);
	var
		Node: TNodePtr;

	begin
		New(Node);
		Node := Head;

		while Node^.NodePtr <> nil do
		begin
			Writeln('=================');
			Writeln(Node^.UserRec.Name);
			Writeln(Node^.UserRec.Surname);
			WriteLn(Node^.UserRec.Email);
			WriteLn(Node^.UserRec.Password);
			Writeln(Node^.UserRec.Id);
			Writeln(Node^.UserRec.Age);
			Writeln(Node^.UserRec.Sex);
			Writeln('=================');

			Node := Node^.NodePtr;
		end;
		Writeln('Done Printing.');
	end;

procedure Auth(Email, Password: String; var isFound: Boolean);
	var
		Node: TNodePtr;
	begin
		New(Node);
		Node := Head;
		isFound := False;

		while Node^.NodePtr <> nil do
		begin
			if (CompareText(Node^.UserRec.Email, Email) = 0) AND (CompareText(Node^.UserRec.Password, Password) = 0) then
			begin
				isFound := True;
				break;
			end;

			Node := Node^.NodePtr;
		end;
	end;

procedure AssignRecord(UserRec: TUserRec; Name, Surname, Email, Password: String; ID, Age: Integer; Sex: Char);
	begin
		SampleRecord.Name := Name;
		SampleRecord.Surname := Surname;
		SampleRecord.Email := Email;
		SampleRecord.Password := Password;
		SampleRecord.Age := Age;
		SampleRecord.Id  := Id;
		SampleRecord.Sex := Sex;
	end;

BEGIN
	ClrScr;
	InitLinkedList;

	AssignRecord(SampleRecord, 'Victor', 'Saliba', 'victor@gmail.com', '1234', 19, 12345, 'M');
	AddRecord(SampleRecord);
	AssignRecord(SampleRecord, 'Mario', 'Petrack', 'mario@gmail.com', '1435', 42, 00011, 'M');
	AddRecord(SampleRecord);
	AssignRecord(SampleRecord, 'Mary', 'Kels', 'mary@asd.com', '32134', 22, 20211, 'F');
	AddRecord(SampleRecord);
	AssignRecord(SampleRecord, 'Pepe', 'Bolimpart', 'pepe@dsa.com', 'pepe123', 19, 04148, 'M');
	AddRecord(SampleRecord);
	AssignRecord(SampleRecord, 'Laura', 'Becks', 'lauri@gmail.com', 'lauri789', 16, 04148, 'F');

	InsertRecordByID(00011, SampleRecord);
	DeleteNodeWithID(20211);

	WriteLn('Done...');
	WriteLn;
	PrintAll(Head);
	WriteLn('Auth...');
	Write('Email: ');
	ReadLn(Email);
	Write('Password: ');
	ReadLn(Password);
	Auth(Email, Password, isAuth);
	WriteLn;

	if isAuth then
		WriteLn('Wellcome!')
	else
		WriteLn('Forbbiden');
END.
