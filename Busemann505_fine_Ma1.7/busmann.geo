// Busemann AIRFOIL MESH -  5%thick
// based on https://github.com/tbellosta/CFD2020/tree/master/DIAMOND
R = 3; 	//domain radius
c = 1; 		//chord - could add a lower adjustment
tu = 0.05;	//thickness of upper airfoil
tl = 0.05;	//thickness of lower airfoil

meshinneru = 0.1;        //body mesh size
meshinnerl = 0.1;        //body mesh size
meshouteru = 0.1;        //body mesh size
meshouterl = 0.1;        //body mesh size

H = 0.505;//overall mesh separation - changed from 0.5
hu = H/2-tu;//
hl = H/2-tl;//

meshfarfield = 1;		//external mesh size, do not decrease!

//========================= POINTS

//farfield
Point(1) = {0, 0, 0, meshfarfield};	//Centerpoint
Point(2) = {R, 0, 0, meshfarfield};
Point(3) = {0, R, 0, meshfarfield};
Point(4) = {-R, 0, 0, meshfarfield};
Point(5) = {0, -R, 0, meshfarfield};

//upper airfoil
Point(6) = {-c/2, H/2, 0, meshinneru};
Point(7) = {0, hu, 0, meshinneru};
Point(8) = {c/2, H/2, 0, meshinneru};

//lower airfoil
Point(9) = {-c/2, -H/2, 0, meshinnerl};
Point(10) = {0, -hl, 0, meshinnerl};
Point(11) = {c/2, -H/2, 0, meshinnerl};

//========================== LINES

// farfield
Circle(1) = {2, 1, 3};
Circle(2) = {3, 1, 4};
Circle(3) = {4, 1, 5};
Circle(4) = {5, 1, 2};

// upper airfoil
Line(5) = {6,7};
Line(6) = {7,8};
Line(7) = {8,6};

// lower airfoil
Line(8) = {9,10};
Line(9) = {10,11};
Line(10) = {11,9};

//=========================== LOOPS

//farfield
Line Loop(1) = {1,2,3,4};
//airfoil
Line Loop(2) = {5,6,7};
//airfoil
Line Loop(3) = {8,9,10};

//=========================== SURFACES
Plane Surface(1) = {1,2,3};

//===============================MESH
//Physical Surface("Volume") = {1};
Physical Volume("internal") = {1};	//added
Physical Line("FARFIELD") = {1,2,3,4};
Physical Line("UPPER AIRFOIL") = {5,6,7};
Physical Line("LOWER AIRFOIL") = {8,9,10};

  Extrude {0, 0, 1} {
   Surface{1};
   Layers{1};
   Recombine;
  }

//Mesh.RandomFactor = 1e-12;
//Mesh.Algorithm = 1;//+//+
Physical Surface("upper airfoil") = {41, 49, 45};
//+
Physical Surface("lower airfoil") = {53, 61, 57};
//+
Physical Surface("front") = {62};
//+
Physical Surface("back") = {1};
//+
Physical Surface("inlet") = {29, 33};
//+
Physical Surface("outlet") = {25, 37};
